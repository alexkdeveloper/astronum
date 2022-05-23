/* window.vala
 *
 * Copyright 2021 Alex
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace Astronum {
	[GtkTemplate (ui = "/com/github/alexkdeveloper/astronum/window.ui")]
	public class Window : Gtk.ApplicationWindow {
		[GtkChild]
        unowned Gtk.Stack stack;
        [GtkChild]
        unowned Gtk.Box data_page;
        [GtkChild]
        unowned Gtk.ScrolledWindow result_page;
        [GtkChild]
        unowned Gtk.Label result_text;
        [GtkChild]
        unowned Gtk.ComboBox combobox;
        [GtkChild]
        unowned Gtk.Entry entry_name;
        [GtkChild]
        unowned Gtk.Entry entry_day;
        [GtkChild]
        unowned Gtk.Entry entry_year;
        [GtkChild]
        unowned Gtk.Button back_button;
        [GtkChild]
        unowned Gtk.Button calculate_button;

		public Window (Gtk.Application app) {
			Object (application: app);
			entry_name.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-clear-symbolic");
        entry_name.icon_press.connect ((pos, event) => {
        if (pos == Gtk.EntryIconPosition.SECONDARY) {
            entry_name.set_text ("");
            entry_name.grab_focus();
           }
        });
        entry_day.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-clear-symbolic");
        entry_day.icon_press.connect ((pos, event) => {
        if (pos == Gtk.EntryIconPosition.SECONDARY) {
              entry_day.set_text("");
              entry_day.grab_focus();
           }
        });
        entry_year.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-clear-symbolic");
        entry_year.icon_press.connect ((pos, event) => {
        if (pos == Gtk.EntryIconPosition.SECONDARY) {
              entry_year.set_text("");
              entry_year.grab_focus();
           }
        });
            set_widget_visible(back_button,false);
            back_button.clicked.connect(go_to_data_page);
            calculate_button.clicked.connect(on_calculate);
		}
		private void on_calculate(){
           if(is_empty(entry_name.get_text())){
             alert("Enter the name");
             entry_name.grab_focus();
             return;
         }
         if(is_empty(entry_day.get_text())){
             alert("Enter the day of births");
             entry_day.grab_focus();
             return;
         }
         if(is_empty(entry_year.get_text())){
             alert("Enter the year of births");
             entry_year.grab_focus();
             return;
         }
            string name = entry_name.get_text();
            int day = int.parse(entry_day.get_text());
            int year = int.parse(entry_year.get_text());

        var calculator = new Calculator();

        if(calculator.name_number(name)==0){
            alert("Enter the correct data in the name field");
            entry_name.grab_focus();
            return;
        }
        if(calculator.name_number(name)==-1){
            alert("When entering a name, only English letters, dashes and spaces are allowed");
            entry_name.grab_focus();
            return;
        }
        int month = combobox.get_active()+1;
        if(input_correct(day,month,year))return;
           stack.visible_child = result_page;
           set_widget_visible(back_button,true);
           StringBuilder string_builder = new StringBuilder ();
         string_builder.append("Name number: ").append(calculator.name_number(name).to_string()).append("\nBirth number: ").append(calculator.births_number(day,month,year).to_string()).append("\n\nPsychomatrix:\n").append(calculator.psychomatrix(day,month,year)).append("\n\nOn the Slavic horoscope: ").append(calculator.slavian_horoscope(day,month)).append("\nOn the zodiacal horoscope: ").append(calculator.zodiac_horoscope(day,month)).append("\nOn the Egyptian horoscope: ").append(calculator.egypt_horoscope(day,month)).append("\nOn the eastern horoscope: ").append(calculator.ost_horoscope(year)).append("\nOn the druid horoscope: ").append(calculator.druid_horoscope(day,month)).append("\nOn the Tibetan horoscope: ").append(calculator.tibet_horoscope(year));
         result_text.set_text(string_builder.str);
        }
        private void go_to_data_page(){
           stack.visible_child = data_page;
           set_widget_visible(back_button,false);
        }
     private bool input_correct(int n,int l,int m){
        var days=0;
        switch (l) {
            case 1:
                days = 30;
                break;
            case 2:
                if (m % 4 == 0 && m % 100 != 0 || m % 400 == 0) days = 29;
                else days = 28;
                break;
            case 3:
                days = 31;
                break;
            case 4:
                days = 30;
                break;
            case 5:
                days = 31;
                break;
            case 6:
                days = 30;
                break;
            case 7:
                days = 31;
                break;
            case 8:
                days = 31;
                break;
            case 9:
                days = 30;
                break;
            case 10:
                days = 31;
                break;
            case 11:
                days = 30;
                break;
            case 12:
                days = 31;
                break;
            default:
                break;
        }
            if (n>days||n==0){
                alert("Incorrect number of the month! Check the consistency of the entered data.");
                entry_day.grab_focus();
                return true;
            }else if (m==0||m<1000||m>9999){
                alert("The year number is out of range! The year number must be in the range from 1000 to 9999 inclusive.");
                entry_year.grab_focus();
                return true;
            }else {
                return false;
            }
    }

     private bool is_empty(string str){
        return str.strip().length == 0;
        }

    private void set_widget_visible (Gtk.Widget widget, bool visible) {
         widget.no_show_all = !visible;
         widget.visible = visible;
  }

    private void alert (string str){
          var dialog_alert = new Gtk.MessageDialog(this, Gtk.DialogFlags.MODAL, Gtk.MessageType.INFO, Gtk.ButtonsType.OK, str);
          dialog_alert.set_title("Message");
          dialog_alert.run();
          dialog_alert.destroy();
       }
	}
}
