namespace Astronum {
    public class Calculator {
        public int name_number(string str){
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
                    case "а":
                    case "и":
                    case "с":
                    case "ъ":
                    case "А":
                    case "И":
                    case "С":
                    case "Ъ":
                        n += 1;
                        break;
                    case "b":
                    case "k":
                    case "t":
                    case "B":
                    case "K":
                    case "T":
                    case "б":
                    case "й":
                    case "т":
                    case "ы":
                    case "Б":
                    case "Й":
                    case "Т":
                    case "Ы":
                        n += 2;
                        break;
                    case "c":
                    case "l":
                    case "u":
                    case "C":
                    case "L":
                    case "U":
                    case "в":
                    case "к":
                    case "у":
                    case "ь":
                    case "В":
                    case "К":
                    case "У":
                    case "Ь":
                        n += 3;
                        break;
                    case "d":
                    case "m":
                    case "v":
                    case "D":
                    case "M":
                    case "V":
                    case "г":
                    case "л":
                    case "ф":
                    case "э":
                    case "Г":
                    case "Л":
                    case "Ф":
                    case "Э":
                        n += 4;
                        break;
                    case "e":
                    case "n":
                    case "w":
                    case "E":
                    case "N":
                    case "W":
                    case "д":
                    case "м":
                    case "х":
                    case "ю":
                    case "Д":
                    case "М":
                    case "Х":
                    case "Ю":
                        n += 5;
                        break;
                    case "f":
                    case "o":
                    case "x":
                    case "F":
                    case "O":
                    case "X":
                    case "е":
                    case "н":
                    case "ц":
                    case "я":
                    case "Е":
                    case "Н":
                    case "Ц":
                    case "Я":
                        n += 6;
                        break;
                    case "g":
                    case "p":
                    case "y":
                    case "G":
                    case "P":
                    case "Y":
                    case "ё":
                    case "о":
                    case "ч":
                    case "Ё":
                    case "О":
                    case "Ч":
                        n += 7;
                        break;
                    case "h":
                    case "q":
                    case "z":
                    case "H":
                    case "Q":
                    case "Z":
                    case "ж":
                    case "п":
                    case "ш":
                    case "Ж":
                    case "П":
                    case "Ш":
                        n += 8;
                        break;
                    case "i":
                    case "r":
                    case "I":
                    case "R":
                    case "з":
                    case "р":
                    case "щ":
                    case "З":
                    case "Р":
                    case "Щ":
                        n += 9;
                        break;
                    default:
                        break;
                }
        }
        return trans_num(n);
     } 
    public int  births_number(int n,int l,int m){
        int numbr=trans_num(n)+trans_num(l)+trans_num(m);
            return trans_num(numbr);
        }
         public string psychomatrix(int n,int l,int m){
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
        public  string  ost_horoscope(int n){
            while (n>12){
                n-=12;
            }
            switch (n){
                case 1:
                    return _("cock");
                case 2:
                    return _("dog");
                case 3:
                    return _("pig");
                case 4:
                    return _("rat");
                case 5:
                    return _("bull");
                case 6:
                    return _("tiger");
                case 7:
                    return _("rabbit");
                case 8:
                    return _("the Dragon");
                case 9:
                    return _("snake");
                case 10:
                    return _("horse");
                case 11:
                    return _("goat");
                case 12:
                    return _("monkey");
                default:
                    return "!!!";
            }
        }
        public  string  tibet_horoscope(int n){
            while (n>12){
                n-=12;
            }
            switch (n){
                case 1:
                    return _("Metal Gong");
                case 2:
                    return _("lake turtle");
                case 3:
                    return _("Leather Bracelet");
                case 4:
                    return _("Black Buffalo");
                case 5:
                    return _("New moon");
                case 6:
                    return _("Hot sun");
                case 7:
                    return _("monk and monkey");
                case 8:
                    return _("Kite");
                case 9:
                    return _("Cobra");
                case 10:
                    return _("Keeper of the Hearth");
                case 11:
                    return _("Water Source");
                case 12:
                    return _("Jade Column");
                default:
                    return "!!!";
            }
        }
          public string zodiac_horoscope(int n,int month){
            string  f;
            if (month==3&&n>20||month==4&&n<21)f=_("Aries");
            else if (month==4&&n>20||month==5&&n<22)f=_("Taurus");
            else if (month==5&&n>21||month==6&&n<22)f=_("Gemini");
            else if (month==6&&n>21||month==7&&n<23)f=_("Cancer");
            else if (month==7&&n>22||month==8&&n<22)f=_("Leo");
            else if (month==8&&n>21||month==9&&n<24)f=_("Virgo");
            else if (month==9&&n>23||month==10&&n<24)f=_("Libra");
            else if (month==10&&n>23||month==11&&n<23)f=_("Scorpio");
            else if (month==11&&n>22||month==12&&n<23)f=_("Sagittarius");
            else if (month==12&&n>22||month==1&&n<21)f=_("Capricorn");
            else if (month==1&&n>20||month==2&&n<20)f=_("Aquarius");
            else if (month==2&&n>19||month==3&&n<21)f=_("Pisces");
            else return "!!!";
            return f;
        }
       public string slavian_horoscope(int n,int month){
            string f;
            if (month==3&&n>9||month==4&&n<11)f=_("ermine");
            else if (month==4&&n>9||month==5&&n<11)f=_("toad");
            else if (month==5&&n>9||month==6&&n<11)f=_("grasshopper");
            else if (month==6&&n>9||month==7&&n<11)f=_("hamster");
            else if (month==7&&n>9||month==8&&n<11)f=_("snail");
            else if (month==8&&n>9||month==9&&n<11)f=_("ant");
            else if (month==9&&n>9||month==10&&n<11)f=_("cockchafer");
            else if (month==10&&n>9||month==11&&n<11)f=_("beaver");
            else if (month==11&&n>9||month==12&&n<11)f=_("dog");
            else if (month==12&&n>9||month==1&&n<11)f=_("bear");
            else if (month==1&&n>9||month==2&&n<11)f=_("wolverine");
            else if (month==2&&n>9||month==3&&n<11)f=_("raven");
            else return "!!!";
            return f;
        }
       public string egypt_horoscope(int n,int month){
            string f;
            if (month==1&&n>0&&n<8||month==6&&n>18&&n<29||month==9&&n>0&&n<8||month==11&&n>17&&n<27)f=_("Nile");
            else if (month==1&&n>7&&n<22||month==2&&n>0&&n<12)f=_("Amon-Ra");
            else if (month==1&&n>21&&n<32||month==9&&n>7&&n<23)f=_("Mut");
            else if (month==2&&n>11&&n<30||month==8&&n>19&&n<32)f=_("Geb");
            else if (month==3&&n>10&&n<32||month==10&&n>17&&n<30||month==12&&n>18&&n<32)f=_("Isida");
            else if (month==3&&n>0&&n<11||month==11&&n>26||month==12&&n<19)f=_("Osiris");
            else if (month==4&&n>0&&n<20||month==11&&n>7&&n<18)f=_("Tot");
            else if (month==5&&n>0&&n<8||month==4&&n>19&&n<31||month==8&&n>11&&n<20)f=_("Gor");
            else if (month==5&&n>7&&n<28||month==6&&n>28||month==7&&n<14)f=_("Anubis");
            else if (month==5&&n>27||month==6&&n<19||month==9&&n>27||month==10&&n<3)f=_("Set");
            else if (month==7&&n>13&&n<29||month==9&&n>22&&n<28||month==10&&n>2&&n<18)f=_("Bastet");
            else if (month==7&&n>28||month==8&&n<12||month==10&&n>29||month==11&&n<8)f=_("Secmet");
            else return "!!!";
            return f;
        }

        public string druid_horoscope(int n,int month){
            if(month==3&&n==21)return _("OAK");
            if (month==6&&n==24)return _("BIRCH");
            if (month==9&&n==23)return _("OLIVE TREE");
            if (month==12&&n==21||month==12&&n==22)return _("BEECH");
            string f;
            if (month==12&&n>22||month==1&&n<2||month==6&&n>24||month==7&&n<5)f=_("APPLE TREE");
            else if (month==1&&n>1||month==1&&n<12||month==7&&n>4||month==7&&n<15)f=_("fir-tree");
            else if(month==1&&n>11||month==1&&n<25||month==7&&n>14||month==7&&n<26)f=_("ELM");
            else if(month==1&&n>24||month==2&&n<4||month==7&&n>25||month==8&&n<5)f=_("CYPRESS");
            else if(month==2&&n>3||month==2&&n<9||month==8&&n>4||month==8&&n<14)f=_("POPLAR");
            else if(month==2&&n>8||month==2&&n<19||month==8&&n>13||month==8&&n<24)f=_("KARTAS SOUTHERN");
            else if(month==2&&n>18||month==2&&n<30||month==8&&n>23||month==9&&n<3)f=_("PINE");
            else if(month==3&&n>0||month==3&&n<11||month==9&&n>2||month==9&&n<13)f=_("osier");
            else if(month==3&&n>10||month==3&&n<21||month==9&&n>12||month==9&&n<23)f=_("LINDEN");
            else if(month==3&&n>21||month==3&&n<32||month==9&&n>23||month==10&&n<4)f=_("HAZEL");
            else if(month==4&&n>0||month==4&&n<11||month==10&&n>3||month==10&&n<14)f=_("ROWAN");
            else if(month==4&&n>10||month==4&&n<21||month==10&&n>13||month==10&&n<24)f=_("MAPLE");
            else if(month==4&&n>20||month==4&&n<31||month==10&&n>23||month==11&&n<3)f=_("hazelnut");
            else if(month==5&&n>0||month==5&&n<15||month==11&&n>2||month==11&&n<12)f=_("JASMINE");
            else if(month==5&&n>14||month==5&&n<25||month==11&&n>11||month==11&&n<22)f=_("CHESTNUT");
            else if(month==5&&n>24||month==6&&n<4||month==11&&n>21||month==12&&n<2)f=_("ash-tree");
            else if(month==6&&n>3||month==6&&n<14||month==12&&n>1||month==12&&n<12)f=_("HORNBEAM");
            else if(month==6&&n>13||month==6&&n<24||month==12&&n>11||month==12&&n<21)f=_("FIG TREE");
            else return "!!!";
            return f;
        }

        private int  trans_num(int num){
            while (num>=10){
                num=(num/10)+(num%10);
            }
            return num;
         }    
    }
}
