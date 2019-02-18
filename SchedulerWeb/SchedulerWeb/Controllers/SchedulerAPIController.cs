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

        // GET: API
        [HttpGet]
        [ActionName("GetFinalSchedule")]
        public IHttpActionResult GetFinalSchedule()
        {
            // generic School id
            int schoolID = 1;

            // fake majors 1 ~ Comp Sci, 3 ~ CyberSecurity
            var staticMajors = new List<int>() { 1, 3 };

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
            // remove internship for SCY since diaz counts both as one
            courseList.Remove(courseList.Where(c => c.MCode == "SCY" && c.CCode == "430").FirstOrDefault());

            // get final schedule
            var finalSchedule = scheduleService.getFinalSchedule(libArts, courseList, "Fall", 2019, 17, 8, schoolID);

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
            return Json(new { finalSchedule = test });
        }
    }
}