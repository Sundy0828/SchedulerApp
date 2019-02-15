using SchedulerWeb.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SchedulerWeb.DataLayer
{
    public class DatabaseService
    {
        protected SchedulerEntities DB;

        public DatabaseService()
        {
            this.DB = new SchedulerEntities();
        }

        public List<Major> getMajors()
        {
            return this.DB.Majors.OrderBy(m => m.Name).ToList();
        }
        public Major getMajor(int id)
        {
            return this.DB.Majors.Where(m => m.ID == id).FirstOrDefault();
        }

        public List<Course> getCourses()
        {
            return this.DB.Courses.OrderBy(c => c.MCode).ThenBy(n => n.CCode).ToList();
        }
        public List<Course> getCoursesForPrerequisites(int id)
        {
            return this.DB.Courses.Where(c => c.ID != id).ToList();
        }
        public Course getCourse(int id)
        {
            return this.DB.Courses.Where(m => m.ID == id).FirstOrDefault();
        }
        public Course getCourse(String courseCode)
        {
            var course = courseCode.Split(' ');
            var MCode = course[0];
            var CCode = course[1];
            return this.DB.Courses.Where(c => c.MCode == MCode && c.CCode == CCode).FirstOrDefault();
        }
        public List<LibArt> getLibArts()
        {
            return this.DB.LibArts.ToList();
        }
        public List<Semester> getSemesters()
        {
            return this.DB.Semesters.ToList();
        }
        public List<Year> getYears()
        {
            return this.DB.Years.ToList();
        }
    }
}