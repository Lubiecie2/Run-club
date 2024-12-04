using BruTile.Wms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace running_club.Pages
{
    public class History
    {
        public int Id { get; set; }
        public string Kcal { get; set; }
        public string Distance { get; set; }
        public string Steps { get; set; }
        public string data { get; set; }
        public List<(double X, double Y)> coordinates { get; set; }
        public string Time { get; set; }


    }

}
