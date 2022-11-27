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
	public class Window : Adw.ApplicationWindow {
		[GtkChild]
        unowned Gtk.Stack stack;
        [GtkChild]
        unowned Adw.Clamp data_page;
        [GtkChild]
        unowned Gtk.ScrolledWindow result_page;
        [GtkChild]
        unowned Gtk.Label result_text;
        [GtkChild]
        unowned Adw.ComboRow combo;
        [GtkChild]
        unowned Adw.EntryRow entry_name;
        [GtkChild]
        unowned Adw.EntryRow entry_day;
        [GtkChild]
        unowned Adw.EntryRow entry_year;
        [GtkChild]
        unowned Gtk.Button back_button;
        [GtkChild]
        unowned Gtk.Button calculate_button;
        [GtkChild]
        unowned Gtk.Button clear_name;
        [GtkChild]
        unowned Gtk.Button clear_day;
        [GtkChild]
        unowned Gtk.Button clear_year;
        [GtkChild]
        unowned Adw.ToastOverlay overlay;

		public Window (Adw.Application app) {
			Object (application: app);
             entry_name.changed.connect((event) => {
                on_entry_change(entry_name, clear_name);
            });
            clear_name.clicked.connect((event) => {
                on_clear_entry(entry_name);
            });
		    entry_day.changed.connect((event) => {
                on_entry_change(entry_day, clear_day);
            });
            clear_day.clicked.connect((event) => {
                on_clear_entry(entry_day);
            });
		    entry_year.changed.connect((event) => {
                on_entry_change(entry_year, clear_year);
            });
            clear_year.clicked.connect((event) => {
                on_clear_entry(entry_year);
            });
            set_widget_visible(back_button,false);
            back_button.clicked.connect(go_to_data_page);
            calculate_button.clicked.connect(on_calculate);
		}
		private void on_clear_entry(Adw.EntryRow entry){
            entry.set_text("");
            entry.grab_focus();
        }
        private void on_entry_change(Adw.EntryRow entry, Gtk.Button clear){
            if (!is_empty(entry.get_text())) {
                clear.set_visible(true);
            } else {
                clear.set_visible(false);
            }
        }
		private void on_calculate(){
           if(is_empty(entry_name.get_text())){
             set_toast(_("Enter the name"));
             entry_name.grab_focus();
             return;
         }
         if(is_empty(entry_day.get_text())){
             set_toast(_("Enter the day of births"));
             entry_day.grab_focus();
             return;
         }
         if(is_empty(entry_year.get_text())){
             set_toast(_("Enter the year of births"));
             entry_year.grab_focus();
             return;
         }
            string name = entry_name.get_text();
            int day = int.parse(entry_day.get_text());
            int year = int.parse(entry_year.get_text());

        var calculator = new Calculator();

        if(calculator.name_number(name)==0){
            alert(_("Enter the correct data in the name field"),"");
            entry_name.grab_focus();
            return;
        }
        int month = (int)combo.get_selected()+1;
        if(input_correct(day,month,year))return;
           stack.visible_child = result_page;
           set_widget_visible(back_button,true);
           set_widget_visible(calculate_button,false);
           StringBuilder string_builder = new StringBuilder ();
         string_builder.append(_("Name number: ")).append(calculator.name_number(name).to_string()).append(_("\nBirth number: ")).append(calculator.births_number(day,month,year).to_string()).append(_("\n\nPsychomatrix:\n")).append(calculator.psychomatrix(day,month,year)).append(_("\n\nOn the Slavic horoscope: ")).append(calculator.slavian_horoscope(day,month)).append(_("\nOn the zodiacal horoscope: ")).append(calculator.zodiac_horoscope(day,month)).append(_("\nOn the Egyptian horoscope: ")).append(calculator.egypt_horoscope(day,month)).append(_("\nOn the eastern horoscope: ")).append(calculator.ost_horoscope(year)).append(_("\nOn the druid horoscope: ")).append(calculator.druid_horoscope(day,month)).append(_("\nOn the Tibetan horoscope: ")).append(calculator.tibet_horoscope(year));
         result_text.set_text(string_builder.str);
        }
        private void go_to_data_page(){
           stack.visible_child = data_page;
           set_widget_visible(back_button,false);
           set_widget_visible(calculate_button,true);
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
                alert(_("Incorrect number of the month! Check the consistency of the entered data."),"");
                entry_day.grab_focus();
                return true;
            }else{
                return false;
            }
    }

     private bool is_empty(string str){
        return str.strip().length == 0;
        }

    private void set_widget_visible (Gtk.Widget widget, bool visible) {
         widget.visible = !visible;
         widget.visible = visible;
  }
     private void set_toast (string str){
            var toast = new Adw.Toast (str);
            toast.set_timeout (3);
            overlay.add_toast (toast);
        }
    private void alert (string heading, string body){
            var dialog_alert = new Adw.MessageDialog(this, heading, body);
            if (body != "") {
                dialog_alert.set_body(body);
            }
            dialog_alert.add_response("ok", _("_OK"));
            dialog_alert.set_response_appearance("ok", SUGGESTED);
            dialog_alert.response.connect((_) => { dialog_alert.close(); });
            dialog_alert.show();
        }
	}
}
