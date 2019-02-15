using SchedulerWeb.DataLayer;
using SchedulerWeb.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SchedulerWeb.Controllers
{
    public class ScheduleController : Controller
    {

        private ScheduleService scheduleService;

        public ScheduleController()
        {
            this.scheduleService = new ScheduleService();
        }

        // GET: Schedule
        public ActionResult Index()
        {
            // fake majors 1 ~ Comp Sci, 3 ~ CyberSecurity
            var staticMajors = new List<int>() { 1, 3 };

            // lib art courses
            var libArts = scheduleService.getLibArtCourses();
            // courses for major
            var courseList = scheduleService.getMajorCourses(staticMajors);

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
            var finalSchedule = scheduleService.getFinalSchedule(libArts, courseList, "Fall", 2019, 17, 8);
            ViewBag.finalSchedule = finalSchedule;


            //var courses = courseList.Concat(libArts);
            //ViewBag.courses = courses.OrderBy(c => c.CCode).ThenBy(c => c.MCode);

            return View();
        }
    }
}