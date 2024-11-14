using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace running_club.Pages
{
    public class Goal
    {
        public string Id { get; set; } // Unikalny identyfikator celu
        public DateTime Date { get; set; } // Data celu
        public double Distance { get; set; } // Dystans w km
        public TimeSpan MinTime { get; set; } // Minimalny czas (w formacie hh:mm:ss)
    }
}
