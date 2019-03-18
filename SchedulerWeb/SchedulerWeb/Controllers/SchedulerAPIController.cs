using Newtonsoft.Json;
using SchedulerWeb.DataLayer;
using SchedulerWeb.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Http.Results;
using System.Web.Script.Serialization;

namespace SchedulerWeb.Controllers
{
    public class SchedulerAPIController : ApiController
    {
        private ScheduleService scheduleService;

        public SchedulerAPIController()
        {
            this.scheduleService = new ScheduleService();
        }

        [HttpGet]
        [ActionName("GetSchools")]
        public IHttpActionResult GetSchools()
        {
            var schoolList = scheduleService.getSchools();

            var schools = schoolList.Select(school => new
            {
                ID = school.ID,
                SchoolName = school.SchoolName,
                PrimaryColor = school.PrimaryColor,
                SecondaryColor = school.SecondayColor
            });

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            var output = serializer.Serialize(schools);
            var test = JsonConvert.DeserializeObject<dynamic>(output);
            return Json(test);
        }

        [HttpGet]
        [ActionName("GetMajors")]
        public IHttpActionResult GetMajors(int schoolID)
        {
            // generic School id
            //int schoolID = 1;
            var MMList = scheduleService.getMajors(schoolID).Where(m => m.ID != 4 && m.IsMajor == true).ToList();

            var MajorMinor = MMList.Select(MM => new
            {
                ID = MM.ID,
                MMName = MM.Name
            });

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            var output = serializer.Serialize(MajorMinor);
            var test = JsonConvert.DeserializeObject<dynamic>(output);
            return Json(test);
        }

        [HttpGet]
        [ActionName("GetMinors")]
        public IHttpActionResult GetMinors(int schoolID)
        {
            // generic School id
            //int schoolID = 1;
            var MMList = scheduleService.getMajors(schoolID).Where(m => m.ID != 4 && m.IsMajor == false).ToList();

            var MajorMinor = MMList.Select(MM => new
            {
                ID = MM.ID,
                MMName = MM.Name
            });

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            var output = serializer.Serialize(MajorMinor);
            var test = JsonConvert.DeserializeObject<dynamic>(output);
            return Json(test);
        }

        [HttpGet]
        [ActionName("GetLibArtCourses")]
        public IHttpActionResult GetLibArtCourses(int schoolID)
        {
            // generic School id
            //int schoolID = 1;

            // lib art courses
            var libArts = scheduleService.getLibArtCourses(schoolID);

            var courses = libArts.Select(course => new
            {
                ID = course.ID,
                MCode = course.MCode,
                CCode = course.CCode,
                SCode = course.SCode,
                Title = course.Title,
                Prerequisites = course.Prerequisites,
                Semester = course.Semester.Description,
                Year = course.Year.Description,
                Credits = course.Credits,
                LibArt = course.LibArt.Description
            });
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            var output = serializer.Serialize(courses);
            var test = JsonConvert.DeserializeObject<dynamic>(output);
            return Json(test);
        }

        [HttpGet]
        [ActionName("GetMajorCourses")]
        public IHttpActionResult GetMajorCourses(int schoolID, string majors)
        {
            // generic School id
            //int schoolID = 1;

            // fake majors 1 ~ Comp Sci, 3 ~ CyberSecurity
            //var staticMajors = new List<int>() { 1, 3 };
            var staticMajors = majors.Split(',').Select(Int32.Parse).ToList();

            // courses for major
            var courseList = scheduleService.getMajorCourses(staticMajors, schoolID);

            var courses = courseList.Select(course => new
            {
                ID = course.ID,
                MCode = course.MCode,
                CCode = course.CCode,
                SCode = course.SCode,
                Title = course.Title,
                Prerequisites = course.Prerequisites,
                Semester = course.Semester.Description,
                Year = course.Year.Description,
                Credits = course.Credits,
                LibArt = course.LibArt.Description
            });
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            var output = serializer.Serialize(courses);
            var test = JsonConvert.DeserializeObject<dynamic>(output);
            return Json(test);
        }

        // GET: API
        [HttpGet]
        [ActionName("GetFinalSchedule")]
        public IHttpActionResult GetFinalSchedule(int schoolID, string majors, string mmCoursesTaken, string libArtCoursesTaken, String startSem, int startYear, int maxCredits, int maxSem)
        {
            // generic School id
            //int schoolID = 1;

            // fake majors 1 ~ Comp Sci, 3 ~ CyberSecurity
            //var staticMajors = new List<int>() { 1, 3 };
            var staticMajors = majors.Split(',').Select(Int32.Parse).ToList();

            // ID's of major/lib art courses taken
            var mmTaken = new List<int>();
            if (mmCoursesTaken != "" && mmCoursesTaken != null)
            {
                mmTaken = mmCoursesTaken.Split(',').Select(Int32.Parse).ToList();
            }
            var libArtTaken = new List<int>();
            if (libArtCoursesTaken != "" && libArtCoursesTaken != null)
            {
                libArtTaken = libArtCoursesTaken.Split(',').Select(Int32.Parse).ToList();
            }
            var takenCourses = mmTaken.Concat(libArtTaken).ToList();

            // lib art courses
            var libArts = scheduleService.getLibArtCourses(schoolID);
            // courses for major
            var courseList = scheduleService.getMajorCourses(staticMajors, schoolID);

            // remove any lib arts that come with the major
            foreach (var course in courseList)
            {
                if (course.LibArt_ID != 1)
                {
                    libArts.Remove(libArts.Where(l => l.LibArt_ID == course.LibArt_ID).FirstOrDefault());
                }
            }

            // get final schedule
            var finalSchedule = scheduleService.getFinalSchedule(libArts, courseList, startSem, startYear, maxCredits, maxSem, schoolID, takenCourses);

            var schedule = new
            {
                semester = finalSchedule.Select(semester => new
                {
                    semester = semester.currSem,
                    year = semester.currYear,
                    credits = semester.currCredits,
                    courses = semester.courses.Select(course => new
                    {
                        ID = course.ID,
                        MCode = course.MCode,
                        CCode = course.CCode,
                        SCode = course.SCode,
                        Title = course.Title,
                        Prerequisites = course.Prerequisites,
                        Semester = course.Semester.Description,
                        Year = course.Year.Description,
                        Credits = course.Credits,
                        LibArt = course.LibArt.Description
                    })
                })
            };
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            var output = serializer.Serialize(schedule);
            var test = JsonConvert.DeserializeObject<dynamic>(output);
            return Json(test);
        }
    }
}