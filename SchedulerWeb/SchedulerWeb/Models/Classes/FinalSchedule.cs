using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SchedulerWeb.Models.Classes
{
    public class FinalSchedule
    {
        public String currSem { get; set; }
        public String currYear { get; set; }
        public String currCredits { get; set; }
        public List<Course> courses { get; set; }
    }
}