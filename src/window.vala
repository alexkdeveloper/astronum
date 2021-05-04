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
	[GtkTemplate (ui = "/org/example/App/window.ui")]
	public class Window : Gtk.ApplicationWindow {
		[GtkChild]
        unowned Gtk.Stack stack;
        [GtkChild]
        unowned Gtk.Box box_data_page;
        [GtkChild]
        unowned Gtk.ScrolledWindow window_result_page;
        [GtkChild]
        unowned Gtk.TextView text_view;
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
        unowned Gtk.Button save_button;
        [GtkChild]
        unowned Gtk.Button calculate_button;
        [GtkChild]
		unowned Gtk.ListStore liststore;

        GLib.Value val;

		public Window (Gtk.Application app) {
			Object (application: app);
			entry_name.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-clear-symbolic");
        entry_name.icon_press.connect ((pos, event) => {
        if (pos == Gtk.EntryIconPosition.SECONDARY) {
            entry_name.set_text ("");
           }
        });
        entry_day.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-clear-symbolic");
        entry_day.icon_press.connect ((pos, event) => {
        if (pos == Gtk.EntryIconPosition.SECONDARY) {
              entry_day.set_text("");
           }
        });
        entry_year.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-clear-symbolic");
        entry_year.icon_press.connect ((pos, event) => {
        if (pos == Gtk.EntryIconPosition.SECONDARY) {
              entry_year.set_text("");
           }
        });
            set_widget_visible(back_button,false);
            set_widget_visible(save_button,false);
            back_button.clicked.connect(go_to_data_page);
            save_button.clicked.connect(save_result);
            calculate_button.clicked.connect(on_calculate);
            combobox.changed.connect(on_select_item);
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
        if(name_number(name)==0){
            alert("Enter the correct data in the name field");
            entry_name.grab_focus();
            return;
        }
        if(name_number(name)==-1){
            alert("When entering a name, only English letters, dashes and spaces are allowed");
            entry_name.grab_focus();
            return;
        }
        int month = combobox.get_active()+1;
        if(input_correct(day,month,year))return;
           stack.visible_child = window_result_page;
           set_widget_visible(back_button,true);
           set_widget_visible(save_button,true);
           StringBuilder string_builder = new StringBuilder ();
         string_builder.append("name number: ").append(name_number(name).to_string()).append("\nbirth number: ").append(births_number(day,month,year).to_string()).append("\npsychomatrix:\n").append(psychomatrix(day,month,year)).append("\non the Slavic horoscope: ").append(slavian_horoscope(day,month)).append("\non the zodiacal horoscope: ").append(zodiac_horoscope(day,month)).append("\non the Egyptian horoscope: ").append(egypt_horoscope(day,month)).append("\non the eastern horoscope: ").append(ost_horoscope(year));
         text_view.buffer.text = string_builder.str;
        }
        private void go_to_data_page(){
           stack.visible_child = box_data_page;
           set_widget_visible(back_button,false);
           set_widget_visible(save_button,false);
        }

        private void save_result(){
        var file_chooser = new Gtk.FileChooserDialog ("Save result", this,
                                      Gtk.FileChooserAction.SAVE,
                                      "_Cancel", Gtk.ResponseType.CANCEL,
                                      "_Save", Gtk.ResponseType.ACCEPT);
        if (file_chooser.run () == Gtk.ResponseType.ACCEPT) {
             StringBuilder sb = new StringBuilder ();
         sb.append("Name: ").append(entry_name.get_text()).append("\n").append("Date of births: ").append(entry_day.get_text()).append(" ").append((string) val).append(" ").append(entry_year.get_text()).append("\n\n\n").append(text_view.buffer.text);
             try {
              FileUtils.set_contents (file_chooser.get_filename(), sb.str);
           } catch (Error e) {
            stderr.printf ("Error: %s\n", e.message);
          }
        }
        file_chooser.destroy ();
     }
     private void on_select_item(){
		    Gtk.TreeIter iter;
            combobox.get_active_iter (out iter);
            liststore.get_value (iter, 0, out val);
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

    private int  name_number(string str){
        var  n=0;
        string[] array = new string[str.length];
        for (int i=0;i<str.length;i++) {
            array[i] = str.get_char(str.index_of_nth_char(i)).to_string();
            switch (array[i]) {
                case "a":
                case "j":
                case "s":
                case "A":
                case "J":
                case "S":
                    n += 1;
                    break;
                case "b":
                case "k":
                case "t":
                case "B":
                case "K":
                case "T":
                    n += 2;
                    break;
                case "c":
                case "l":
                case "u":
                case "C":
                case "L":
                case "U":
                    n += 3;
                    break;
                case "d":
                case "m":
                case "v":
                case "D":
                case "M":
                case "V":
                    n += 4;
                    break;
                case "e":
                case "n":
                case "w":
                case "E":
                case "N":
                case "W":
                    n += 5;
                    break;
                case "f":
                case "o":
                case "x":
                case "F":
                case "O":
                case "X":
                    n += 6;
                    break;
                case "g":
                case "p":
                case "y":
                case "G":
                case "P":
                case "Y":
                    n += 7;
                    break;
                case "h":
                case "q":
                case "z":
                case "H":
                case "Q":
                case "Z":
                    n += 8;
                    break;
                case "i":
                case "r":
                case "I":
                case "R":
                    n += 9;
                    break;
                case " ":
                case "-":
                    n += 0;
                    break;
                default:
                    return -1;
            }
    }
    return trans_num(n);
 }
 private int  trans_num(int num){
        while (num>=10){
            num=(num/10)+(num%10);
        }
        return num;
     }

     private int  births_number(int n,int l,int m){
    int numbr=trans_num(n)+trans_num(l)+trans_num(m);
        return trans_num(numbr);
    }
     private string psychomatrix(int n,int l,int m){
        int[] mas = new int[16];

        mas[0] = (n / 10);
        mas[1] = n % 10;

        int c;
        int z;

        if (mas[0] == 0)
        {
            c= mas[1];
        } else
        {
            c= mas[0];
        }

        mas[4]= m % 10;
        z = m / 10;
        mas[5] = z % 10;
        z = z / 10;
        mas[6] = z % 10;
        z = z / 10;
        mas[7]=z;

      if(l<10){
          mas[2]=0;
          mas[3]=l;
      }else{
          mas[2]=1;
          mas[3]=l-10;
      }

        int sum = mas[0] + mas[1] + mas[2] + mas[3] + mas[4] + mas[5] + mas[6] + mas[7];

        mas[8] = sum/ 10;
        mas[9] = sum % 10;

        mas[10] = (mas[8]+mas[9])/ 10;
        mas[11] = (mas[8]+mas[9])% 10;

        mas[12] = (sum-(2*c)) / 10;
        mas[13] = (sum-(2*c)) % 10;

        mas[14] = (mas[12]+mas[13]) / 10;
        mas[15] = (mas[12]+mas[13]) % 10;
        string[] str = new string[9];
        for (var i=0;i<9;i++){
            str[i]="";
        }
        for (var i=0;i<16;i++){
            switch (mas[i]){
                case 0:break;
                case 1:str[0]=str[0]+"1";break;
                case 2:str[1]=str[1]+"2";break;
                case 3:str[2]=str[2]+"3";break;
                case 4:str[3]=str[3]+"4";break;
                case 5:str[4]=str[4]+"5";break;
                case 6:str[5]=str[5]+"6";break;
                case 7:str[6]=str[6]+"7";break;
                case 8:str[7]=str[7]+"8";break;
                case 9:str[8]=str[8]+"9";break;default:break;
            }
        }
        string matrix = "";
        for(int i=0;i<9;i++){
             if(i==2||i==5){
                matrix=matrix+str[i]+"\n";
             }else{
                matrix=matrix+str[i]+"  ";
             }
        }
        return matrix;
    }
    private  string  ost_horoscope(int n){
        while (n>12){
            n-=12;
        }
        switch (n){
            case 1:
                return "cock";
            case 2:
                return "dog";
            case 3:
                return "pig";
            case 4:
                return "rat";
            case 5:
                return "bull";
            case 6:
                return "tiger";
            case 7:
                return "rabbit";
            case 8:
                return "the Dragon";
            case 9:
                return "snake";
            case 10:
                return "horse";
            case 11:
                return "goat";
            case 12:
                return "monkey";
            default:
                return "!!!";
        }
    }
      private string zodiac_horoscope(int n,int month){
        string  f;
        if (month==3&&n>20||month==4&&n<21)f="Aries";
        else if (month==4&&n>20||month==5&&n<22)f="Taurus";
        else if (month==5&&n>21||month==6&&n<22)f="Gemini";
        else if (month==6&&n>21||month==7&&n<23)f="Cancer";
        else if (month==7&&n>22||month==8&&n<22)f="Leo";
        else if (month==8&&n>21||month==9&&n<24)f="Virgo";
        else if (month==9&&n>23||month==10&&n<24)f="Libra";
        else if (month==10&&n>23||month==11&&n<23)f="Scorpio";
        else if (month==11&&n>22||month==12&&n<23)f="Sagittarius";
        else if (month==12&&n>22||month==1&&n<21)f="Capricorn";
        else if (month==1&&n>20||month==2&&n<20)f="Aquarius";
        else if (month==2&&n>19||month==3&&n<21)f="Pisces";
        else return "!!!";
        return f;
    }
   private string slavian_horoscope(int n,int month){
        string f;
        if (month==3&&n>9||month==4&&n<11)f="ermine";
        else if (month==4&&n>9||month==5&&n<11)f="toad";
        else if (month==5&&n>9||month==6&&n<11)f="grasshopper";
        else if (month==6&&n>9||month==7&&n<11)f="hamster";
        else if (month==7&&n>9||month==8&&n<11)f="snail";
        else if (month==8&&n>9||month==9&&n<11)f="ant";
        else if (month==9&&n>9||month==10&&n<11)f="cockchafer";
        else if (month==10&&n>9||month==11&&n<11)f="beaver";
        else if (month==11&&n>9||month==12&&n<11)f="dog";
        else if (month==12&&n>9||month==1&&n<11)f="bear";
        else if (month==1&&n>9||month==2&&n<11)f="wolverine";
        else if (month==2&&n>9||month==3&&n<11)f="raven";
        else return "!!!";
        return f;
    }
   private string egypt_horoscope(int n,int month){
        string f;
        if (month==1&&n>0&&n<8||month==6&&n>18&&n<29||month==9&&n>0&&n<8||month==11&&n>17&&n<27)f="Nile";
        else if (month==1&&n>7&&n<22||month==2&&n>0&&n<12)f="Amon-Ra";
        else if (month==1&&n>21&&n<32||month==9&&n>7&&n<23)f="Mut";
        else if (month==2&&n>11&&n<30||month==8&&n>19&&n<32)f="Geb";
        else if (month==3&&n>10&&n<32||month==10&&n>17&&n<30||month==12&&n>18&&n<32)f="Isida";
        else if (month==3&&n>0&&n<11||month==11&&n>26||month==12&&n<19)f="Osiris";
        else if (month==4&&n>0&&n<20||month==11&&n>7&&n<18)f="Tot";
        else if (month==5&&n>0&&n<8||month==4&&n>19&&n<31||month==8&&n>11&&n<20)f="Gor";
        else if (month==5&&n>7&&n<28||month==6&&n>28||month==7&&n<14)f="Anubis";
        else if (month==5&&n>27||month==6&&n<19||month==9&&n>27||month==10&&n<3)f="Set";
        else if (month==7&&n>13&&n<29||month==9&&n>22&&n<28||month==10&&n>2&&n<18)f="Bastet";
        else if (month==7&&n>28||month==8&&n<12||month==10&&n>29||month==11&&n<8)f="Secmet";
        else return "!!!";
        return f;
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
