using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SchedulerWeb.DataLayer;
using SchedulerWeb.Models;

namespace SchedulerWeb.Controllers
{
    public class AdminController : Controller
    {
        private AdminService adminService;

        public AdminController()
        {
            this.adminService = new AdminService();
        }

        #region Majors
        // GET: Admin
        public ActionResult Majors()
        {
            // generic School id
            int schoolID = 1;
            var majors = adminService.getMajors(schoolID);
            ViewBag.majors = majors;
            return View();
        }

        // GET: Admin
        public ActionResult AddMajor()
        {
            return View();
        }

        // GET: Admin
        public ActionResult EditMajor(int id)
        {
            // generic School id
            int schoolID = 1;
            var major = adminService.getMajor(id);
            var holder = major.Courses == null ? "" : major.Courses;
            var majorCourses = holder;
            var courses = adminService.getCourses(schoolID);
            ViewBag.major = major;
            ViewBag.courses = courses;
            ViewBag.majorCourses = majorCourses;
            return View();
        }

        // GET: Admin
        public ActionResult CreateMajor(String name, String isMajor)
        {
            // generic School id
            int schoolID = 1;
            adminService.CreateMajor(name, isMajor == "on", schoolID);
            return RedirectToAction("Majors", "Admin");
        }

        // GET: Admin
        public ActionResult UpdateMajor(int id, String name, Boolean isMajor, String courses)
        {
            var courseList = courses.Split(',');
            Array.Sort(courseList);
            string coursesSort = string.Join(",", courseList);
            adminService.UpdateMajor(id, name, isMajor, coursesSort);
            return RedirectToAction("Majors", "Admin");
        }

        // GET: Admin
        public ActionResult DeleteMajor(int id)
        {
            adminService.DeleteMajor(id);
            return RedirectToAction("Majors", "Admin");
        }
        #endregion

        #region Courses
        // GET: Admin
        public ActionResult Courses()
        {
            // generic School id
            int schoolID = 1;
            var courses = adminService.getCourses(schoolID);
            ViewBag.courses = courses;
            return View();
        }

        // GET: Admin
        public ActionResult AddCourse()
        {
            var semester = adminService.getSemesters();
            var year = adminService.getYears();
            var libArt = adminService.getLibArts();
            ViewBag.semester = semester;
            ViewBag.year = year;
            ViewBag.libArt = libArt;
            return View();
        }

        // GET: Admin
        public ActionResult EditCourse(int id)
        {
            // generic School id
            int schoolID = 1;
            var semester = adminService.getSemesters();
            var year = adminService.getYears();
            var libArt = adminService.getLibArts();
            var course = adminService.getCourse(id);
            
            var prerequisites = course.Prerequisites.Split(new[] { "//" }, StringSplitOptions.None);
            List<List<Course>> coursePrerequisites = new List<List<Course>>();
            foreach (var item in prerequisites)
            {
                var items = item.Split(',');
                List<Course> courseList = new List<Course>();
                foreach (var c in items)
                {
                    courseList.Add(adminService.getCourse(c, schoolID));
                }
                coursePrerequisites.Add(courseList);
            }
            
            ViewBag.semester = semester;
            ViewBag.year = year;
            ViewBag.libArt = libArt;
            ViewBag.course = course;
            ViewBag.coursePrerequisites = coursePrerequisites;
            ViewBag.optionCount = coursePrerequisites.Count() + 1;
            return View();
        }

        // GET: Admin
        public ActionResult CoursesNeeded(int courseID)
        {
            // generic School id
            int schoolID = 1;
            var course = adminService.getCourse(courseID);
            var courses = adminService.getCoursesForPrerequisites(course.ID, schoolID);
            var coursePrerequisites = course.Prerequisites == null ? "" : course.Prerequisites;
            ViewBag.courses = courses;
            ViewBag.coursePrerequisites = coursePrerequisites;
            return PartialView();
        }

        // GET: Admin
        public ActionResult CreateCourse(String major, String course, String section, String title, int semester, int year, int LibArt, int credits)
        {
            // generic School id
            int schoolID = 1;
            adminService.CreateCourse(major, course, section, title, semester, year, LibArt, credits, schoolID);
            return RedirectToAction("Courses", "Admin");
        }

        // GET: Admin
        public ActionResult UpdateCourse(int id, String major, String course, String section, String title, int semester, int year, int libArt, int credits, String[] prerequisites)
        {
            string coursesSort = string.Join("//", prerequisites);
            adminService.UpdateCourse(id, major, course, section, title, semester, year, libArt, credits, coursesSort);
            return RedirectToAction("Courses", "Admin");
        }

        // GET: Admin
        public ActionResult DeleteCourse(int id)
        {
            adminService.DeleteCourse(id);
            return RedirectToAction("Courses", "Admin");
        }
        #endregion
    }
}