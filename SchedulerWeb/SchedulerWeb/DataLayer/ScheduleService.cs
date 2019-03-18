using SchedulerWeb.Models;
using SchedulerWeb.Models.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace SchedulerWeb.DataLayer
{
    public class ScheduleService : DatabaseService
    {
        public List<School> getSchools()
        {
            return this.DB.Schools.ToList();
        }
        public List<Course> getLibArtCourses(int schoolID)
        {
            // loop through lib art major courses
            var major = getMajor(4);
            var courseList = new List<Course>();
            var majorCourses = major.Courses.Split(',');
            foreach (var courseCode in majorCourses)
            {
                // add lib art courses if not in list
                var courseItem = getCourse(courseCode, schoolID);
                if (!courseList.Contains(courseItem))
                {
                    courseList.Add(courseItem);
                }
            }
            return courseList.OrderBy(c => c.CCode).ToList();
        }
        public List<Course> getLibArtCourses(int schoolID, List<int> coursesTaken)
        {
            // loop through lib art major courses
            var major = getMajor(4);
            var courseList = new List<Course>();
            var majorCourses = major.Courses.Split(',');
            foreach (var courseCode in majorCourses)
            {
                // add lib art courses if not in list
                var courseItem = getCourse(courseCode, schoolID);
                if (!coursesTaken.Contains(courseItem.ID))
                {
                    if (!courseList.Contains(courseItem))
                    {
                        courseList.Add(courseItem);
                    }
                }
            }
            return courseList.OrderBy(c => c.CCode).ToList();
        }

        public List<Course> getMajorCourses(List<int> staticMajors, int schoolID)
        {
            // loop through majors
            var courseList = new List<Course>();
            foreach (var major_ID in staticMajors)
            {
                // get major courses based off of id
                var major = getMajor(major_ID);
                var majorCourses = major.Courses.Split(',');
                foreach (var courseCode in majorCourses)
                {
                    // add major if not in list
                    var courseItem = getCourse(courseCode, schoolID);
                    if (!courseList.Contains(courseItem))
                    {
                        courseList.Add(courseItem);
                    }

                }
            }
            return courseList.OrderBy(c => c.CCode).ToList();
        }
        public List<Course> getMajorCourses(List<int> staticMajors, int schoolID, List<int> coursesTaken)
        {
            // loop through majors
            var courseList = new List<Course>();
            foreach (var major_ID in staticMajors)
            {
                // get major courses based off of id
                var major = getMajor(major_ID);
                var majorCourses = major.Courses.Split(',');
                foreach (var courseCode in majorCourses)
                {
                    // add major if not in list
                    var courseItem = getCourse(courseCode, schoolID);
                    if (!coursesTaken.Contains(courseItem.ID))
                    {
                        if (!courseList.Contains(courseItem))
                        {
                            courseList.Add(courseItem);
                        }
                    }

                }
            }
            return courseList.OrderBy(c => c.CCode).ToList();
        }

        private Dictionary<String, Course> courseCodes = new Dictionary<String, Course>();
        private Dictionary<Course, int> priorityList = new Dictionary<Course, int>();
        // this is to add priority to courses, Programming 1 gets higher priority since
        // it is the bottom of the tree and needed for everything
        public void priorityListLoop(List<Course> courseList, int schoolID, int priorityCount = 0)
        {
            // loop through all courses
            foreach (var course in courseList)
            {
                var count = 0;
                // if prerequisites needed
                if (course.Prerequisites != null && course.Prerequisites != "")
                {
                    // get list of prerequisites
                    List<Course> prerequisitesList = new List<Course>();
                    // get all options for prerequisites
                    var prereqOptions = course.Prerequisites.Split(new[] { "//" }, StringSplitOptions.None);
                    var majorPrerequisites = new List<String>();
                    foreach (var prereqOption in prereqOptions)
                    {
                        majorPrerequisites.AddRange(prereqOption.Split(','));
                    }
                    // loop through prerequisites and add them to list
                    foreach (var courseCode in majorPrerequisites)
                    {
                        var courseItem = courseCodes[courseCode];
                        prerequisitesList.Add(courseItem);
                    }
                    // go back through list to make sure base values get more priority
                    count = (Int32.Parse(course.CCode) / 100);
                    if (course.Semester_ID != 3 && course.LibArt_ID != 3)
                    {
                        count += 1;
                    }
                    priorityListLoop(prerequisitesList, schoolID, count);
                }
                priorityList[course] += priorityCount + 1;
            }
        }
        // loop through course to check if prerequisites are met
        public Course getNextCourse(Course course, List<Course> taken, List<Course> curTaken, int schoolID)
        {
            var courseHolder = course;
            // if no prerequisites just return course
            if (course.Prerequisites == null || course.Prerequisites == "")
            {
                return courseHolder;
            }
            else
            {
                //loop through the different options for prerequisites
                var prereqOptions = course.Prerequisites.Split(new[] { "//" }, StringSplitOptions.None);
                foreach (var prereqOption in prereqOptions)
                {
                    // loop through prerequisites
                    var majorCourses = prereqOption.Split(',');
                    var prereqTaken = false;
                    foreach (var courseCode in majorCourses)
                    {
                        // if course not taken loop through that course to check if prerequisites are met
                        var courseItem = courseCodes[courseCode];
                        // if junior status and prerequisites are currently being taken
                        if (taken.Sum(t => t.Credits) >= 60)
                        {
                            if (curTaken.Contains(courseItem) || taken.Contains(courseItem))
                            {
                                prereqTaken = true;
                            }
                            else
                            {
                                prereqTaken = false;
                                break;
                            }
                        }
                    }
                    if (prereqTaken)
                    {
                        // return most base course based off taken and currently taken courses
                        return courseHolder;
                    }
                    foreach (var courseCode in majorCourses)
                    {
                        // if course not taken loop through that course to check if prerequisites are met
                        var courseItem = courseCodes[courseCode];
                        if (!taken.Contains(courseItem))
                        {
                            courseHolder = getNextCourse(courseItem, taken, curTaken, schoolID);
                        }
                    }
                    // return most base course based off taken courses
                    return courseHolder;
                }
                // return most base course based off taken courses
                return courseHolder;

            }
        }

        public List<FinalSchedule> getFinalSchedule(List<Course> libArt2, List<Course> courseList, String startSem, int startYear, int maxCredits, int maxSem, int schoolID, List<int> takenCourses)
        {
            // generic values to keep track of data
            var currentCredits = 0;
            var libArt = libArt2;
            List<Course> curTaken = new List<Course>();
            
            // important values for semester
            List<Course> taken = new List<Course>();
            var finalSchedule = new List<FinalSchedule>();
            var currentSem = startSem;
            var currentYear = startYear;
            var totCredits = 0;

            // check for course hit its max load
            var courseDone = false;

            // set priority list
            foreach (var course in courseList)
            {
                priorityList.Add(course, 0);
                courseCodes.Add(course.MCode + " " + course.CCode, course);
            }
            // set priority to each course and order by priority
            priorityListLoop(courseList, schoolID);
            priorityList = priorityList.OrderByDescending(x => x.Value).ToDictionary(x => x.Key, x => x.Value);

            
            // add previously taken courses
            foreach (var ID in takenCourses)
            {
                var course = getCourse(ID);
                courseList.Remove(course);
                curTaken.Add(course);
            }
            // add current semester and courses to final schedule
            var semester = new FinalSchedule()
            {
                currSem = "Precollege",
                currYear = "Courses",
                currCredits = taken.Sum(t => t.Credits).ToString(),
                courses = curTaken
            };
            finalSchedule.Add(semester);
            // join curent taken, and overall taken
            taken.AddRange(curTaken);
            // reset generic values
            curTaken = new List<Course>();



            // loop through until all courses are completed
            for (int j = 0; j < maxSem; j++)
            {
                // check if odd/even
                var curYear = currentYear % 2 == 1 ? 1 : 2;
                // check if fall/spring
                var curSem = currentSem == "Fall" ? 1 : 2;

                List<Course> courses = new List<Course>();
                while (currentCredits <= maxCredits)
                {
                    // less often courses, every semster/year courses, and every year but not every semester
                    var curSemCourseList = courseList.Where(c => (c.Year_ID == curYear) && (c.Semester_ID == curSem)).ToList();
                    var everyYearCourseList = courseList.Where(c => (c.Year_ID == 3) && (c.Semester_ID == curSem)).ToList();
                    var everySemCourseList = courseList.Where(c => (c.Year_ID == 3) && (c.Semester_ID == 3)).ToList();
                    // join courses together
                    curSemCourseList.AddRange(everySemCourseList);
                    curSemCourseList.AddRange(everyYearCourseList);
                    var curCourseList = curSemCourseList;

                    // lib art courses
                    var curLibArt = libArt.ToList();
                    // if freshman add connections class
                    var connections = libArt.Where(l => l.Title == "Lib Art ~ Connections").FirstOrDefault();
                    if (connections != null)
                    {
                        courses.Add(connections);
                        curTaken.Add(connections);
                        libArt.Remove(connections);
                        currentCredits += connections.Credits;
                    }
                    
                    for (int i = 0; i < 2; i++) { 
                    // loop through priority list and add major courses first
                    foreach (var item in priorityList)
                    {
                        // make sure not over credits
                        if (currentCredits + item.Key.Credits <= maxCredits)
                        {
                            // check if course is avaliable now
                            if (curCourseList.Contains(item.Key))
                            {
                                // get next course, based off taken courses
                                var course = getNextCourse(item.Key, taken, curTaken, schoolID);
                                // check if course was taken yet based off taken courses
                                if (!curTaken.Contains(course))
                                {
                                    if (!taken.Contains(course))
                                    {
                                        if ((taken.Sum(t => t.Credits) < 60 && Int16.Parse(course.CCode) < 300) || taken.Sum(t => t.Credits) >= 60)
                                        {
                                            courses.Add(course);
                                            curTaken.Add(course);
                                            courseList.Remove(course);
                                            currentCredits += course.Credits;
                                        }
                                    }
                                }
                            }
                        }
                        else
                        {
                            courseDone = true;
                        }
                    }
                    }
                    // loop through lib art courses and add where needed
                    foreach (var course in curLibArt)
                    {
                        // make sure not over credits
                        if (currentCredits + course.Credits <= maxCredits)
                        {
                            // check if course was taken yet based off taken courses
                            if (!curTaken.Contains(course))
                            {
                                if (!taken.Contains(course))
                                {
                                    courses.Add(course);
                                    curTaken.Add(course);
                                    libArt.Remove(course);
                                    currentCredits += course.Credits;
                                }
                            }
                        }
                        else
                        {
                            courseDone = true;
                        }
                    }
                    if (courseDone)
                    {
                        break;
                    }
                }

                // add current semester and courses to final schedule
                semester = new FinalSchedule(){
                    currSem = currentSem,
                    currYear = currentYear.ToString(),
                    currCredits = currentCredits + " / " + (taken.Sum(t => t.Credits) + currentCredits),
                    courses = courses
                };
                finalSchedule.Add(semester);
                // join curent taken, and overall taken
                taken.AddRange(curTaken);
                // reset generic values
                curTaken = new List<Course>();
                currentCredits = 0;
                totCredits += currentCredits;

                // set next semester, and if switching to spring add one to the year
                if (currentSem == "Fall")
                {
                    currentSem = "Spring";
                    currentYear += 1;
                }
                else
                {
                    currentSem = "Fall";
                }
            }

            if (courseList.Count() > 0 || libArt.Count() > 0)
            {
                var one = "Leftover";
                var two = "Courses";
                courseList.AddRange(libArt);

                var leftovers = new FinalSchedule()
                {
                    currSem = one,
                    currYear = two,
                    currCredits = courseList.Sum(t => t.Credits) + " / " + (taken.Sum(t => t.Credits) + courseList.Sum(t => t.Credits)),
                    courses = courseList
                };
                finalSchedule.Add(leftovers);
            }

            return finalSchedule;

        }
    }
}