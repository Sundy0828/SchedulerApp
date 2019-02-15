using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SchedulerWeb.DataLayer;

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
            var majors = adminService.getMajors();
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
            var major = adminService.getMajor(id);
            var holder = major.Courses == null ? "" : major.Courses;
            var majorCourses = holder;
            var courses = adminService.getCourses();
            ViewBag.major = major;
            ViewBag.courses = courses;
            ViewBag.majorCourses = majorCourses;
            return View();
        }

        // GET: Admin
        public ActionResult CreateMajor(String name, String isMajor)
        {
            adminService.CreateMajor(name, isMajor == "on");
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
            var courses = adminService.getCourses();
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
            var semester = adminService.getSemesters();
            var year = adminService.getYears();
            var libArt = adminService.getLibArts();
            var course = adminService.getCourse(id);
            var courses = adminService.getCoursesForPrerequisites(course.ID);
            var holder = course.Prerequisites == null ? "" : course.Prerequisites;
            var coursePrerequisites = holder;
            ViewBag.semester = semester;
            ViewBag.year = year;
            ViewBag.libArt = libArt;
            ViewBag.course = course;
            ViewBag.courses = courses;
            ViewBag.coursePrerequisites = coursePrerequisites;
            return View();
        }

        // GET: Admin
        public ActionResult CreateCourse(String major, String course, String section, String title, int semester, int year, int LibArt, int credits)
        {
            adminService.CreateCourse(major, course, section, title, semester, year, LibArt, credits);
            return RedirectToAction("Courses", "Admin");
        }

        // GET: Admin
        public ActionResult UpdateCourse(int id, String major, String course, String section, String title, int semester, int year, int libArt, int credits, String prerequisites)
        {
            var courseList = prerequisites.Split(',');
            Array.Sort(courseList);
            string coursesSort = string.Join(",", courseList);
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