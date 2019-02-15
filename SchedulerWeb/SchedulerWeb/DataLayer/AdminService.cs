using System;
using System.Collections.Generic;
using System.Linq;
using SchedulerWeb.Models;
using System.Web;

namespace SchedulerWeb.DataLayer
{
    public class AdminService : DatabaseService
    {
        public void CreateCourse(String major, String course, String section, String title, int semester, int year, int LibArt, int credits, int school)
        {
            var newCourse = new Course()
            {
                MCode = major,
                CCode = course,
                SCode = section,
                Title = title,
                Semester_ID = semester,
                Year_ID = year,
                LibArt_ID = LibArt,
                Credits = credits,
                School_ID = school
            };

            this.DB.Courses.Add(newCourse);
            this.DB.SaveChanges();
        }
        public void UpdateCourse(int id, String major, String course, String section, String title, int semester, int year, int libArt, int credits, String prerequisites)
        {
            var existCourse = getCourse(id);
            existCourse.MCode = major;
            existCourse.CCode = course;
            existCourse.SCode = section;
            existCourse.Title = title;
            existCourse.Semester_ID = semester;
            existCourse.Year_ID = year;
            existCourse.LibArt_ID = libArt;
            existCourse.Credits = credits;
            existCourse.Prerequisites = prerequisites;
            
            this.DB.SaveChanges();
        }
        public void DeleteCourse(int id)
        {
            var course = getCourse(id);

            this.DB.Courses.Remove(course);
            this.DB.SaveChanges();
        }


        public void CreateMajor(String name, Boolean isMajor, int school)
        {
            var newMajor = new Major()
            {
                Name = name,
                IsMajor = isMajor,
                School_ID = school
            };

            this.DB.Majors.Add(newMajor);
            this.DB.SaveChanges();
        }
        public void UpdateMajor(int id, String name, Boolean isMajor, String courses)
        {
            var existMajor = getMajor(id);
            existMajor.Name = name;
            existMajor.IsMajor = isMajor;
            existMajor.Courses = courses;
            
            this.DB.SaveChanges();
        }
        public void DeleteMajor(int id)
        {
            var major = getMajor(id);

            this.DB.Majors.Remove(major);
            this.DB.SaveChanges();
        }
    }
}