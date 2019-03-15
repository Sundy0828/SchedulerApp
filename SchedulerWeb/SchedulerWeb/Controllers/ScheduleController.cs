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
            var schools = scheduleService.getSchools();
            ViewBag.Schools = schools;
            return View();
        }

        // GET: Schedule
        public ActionResult FinalSchedule(int schoolID, string majors, string mmCoursesTaken, string libArtCoursesTaken, String startSem, int startYear, int maxCredits, int maxSem)
        {
            // generic School id
            //int schoolID = 1;

            // fake majors 1 ~ Comp Sci, 3 ~ CyberSecurity
            //var staticMajors = new List<int>() { 1, 3 };
            var staticMajors = majors.Split(',').Select(Int32.Parse).ToList();

            // ID's of major/lib art courses taken
            var mmTaken = new List<int>();
            if (mmCoursesTaken != "")
            {
                mmTaken = mmCoursesTaken.Split(',').Select(Int32.Parse).ToList();
            }
            var libArtTaken = new List<int>();
            if (libArtCoursesTaken != "")
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
            ViewBag.finalSchedule = finalSchedule;

            return View();
        }
    }
}