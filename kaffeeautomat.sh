#!/bin/bash
state="WAIT_FOR_COIN";

get_input() {
  read -p "[$USER@kaffeeautomat ~]$ " line
}

info_text() {
  cat << EOM
Mögliche Eingaben sind:
0,01         1 Cent
0,02         2 Cent
0,05         5 Cent
0,10         10 Cent
0,20         20 Cent
0,50         50 Cent
1,00         1 Euro
2,00         2 Euro

RÜCKGABE     Gibt das eingeworfene Geld zurück.
RAUSNEHMEN   Nimmt das Getränk aus der Ausgabe.
K            Einen Kaffee. Kostet 50 Cent.
B            Ein Bier. Kostet 1 Euro.
S            Einen Schnaps. Kostet 1,50 Euro.
H            Alls zemmat. Kostet 2,00 Euro.

EOM
}

rueckgabe() {
  case $state in
    0,50)
      echo "Nehmen Sie 50 Cent aus dem Ausgabefach."
      state="WAIT_FOR_COIN"
      ;;
    1,00)
      echo "Nehmen Sie 1 Euro aus dem Ausgabefach."
      state="WAIT_FOR_COIN"
      ;;
    1,50)
      echo "Nehmen Sie 1,50 Euro aus dem Ausgabefach."
      state="WAIT_FOR_COIN"
      ;;
    2,00)
      echo "Nehmen Sie 2,00 Euro aus dem Ausgabefach."
      state="WAIT_FOR_COIN"
      ;;
    *) echo "Irgendwas deppats isch passiert heinamol.";;
  esac
}

info_text

while :
do
 get_input

 case $line in
   0,50)
    case $state in
      WAIT_FOR_COIN)
        state="0,50"
        echo "Kredit: 0,50€"
        ;;
      0,50)
        state="1,00"
        echo "Kredit: 1,00€"
        ;;
      1,00)
        state="1,50"
        echo "Kredit: 1,50€"
        ;;
      1,50)
        state="2,00"
        echo "Kredit: 2,00€"
        ;;
      *) rueckgabe;;
    esac
    ;;
   1,00)
    case $state in
      WAIT_FOR_COIN)
        state="1,00"
        echo "Kredit: 1,00"
        ;;
      0,50)
        state="1,50"
        echo "Kredit: 1,50"
        ;;
      1,00)
        state="2,00"
        echo "Kredit: 2,00"
        ;;
      *) rueckgabe;;
    esac
    ;;
   2,00)
    case $state in
      WAIT_FOR_COIN)
        state="2,00"
        echo "Kredit: 2,00"
        ;;
      *) rueckgabe;;
    esac
   ;;
   RÜCKGABE) rueckgabe;;
   RAUSNEHMEN)
    case $state in
      FINISHED)
        echo "Lassen Sie es sich schmecken!"
        state="WAIT_FOR_COIN"
        ;;
      *) echo "Sind sie irgendwie blöd?";;
    esac
    ;;
   K)
    case $state in
      WAIT_FOR_COIN)
        echo "Bitte werfen Sie Geld ein! Kaffee kostet 0,50€."
        ;;
      0,50)
        echo "Kaffee wird ausgegeben. Bitte nehmen Sie ihn danach aus der Ausgabe."
        state="FINISHED"
        ;;
      1,00)
        echo "Kaffee wird ausgegeben. Bitte nehmen Sie ihn danach aus der Ausgabe. Sie bekommen außerdem 0,50€ zurück."
        state="0,50"
        rueckgabe
        state="FINISHED"
        ;;
      1,50)
        echo "Kaffee wird ausgegeben. Bitte nehmen Sie ihn danach aus der Ausgabe. Sie bekommen außerdem 1,00€ zurück."
        state="1,00"
        rueckgabe
        state="FINISHED"
        ;;
      2,00)
        echo "Kaffee wird ausgegeben. Bitte nehmen Sie ihn danach aus der Ausgabe. Sie bekommen außerdem 1,50€ zurück."
        state="1,50"
        rueckgabe
        state "FINISHED"
        ;;
      FINISHED)
        echo "Es ist noch ein Getränk in der Ausgabe. Bitte rausnehmen!"
        ;;
      *) echo "Was komisches ist passiert.";;
    esac
    ;;
   B)
    case $state in
      WAIT_FOR_COIN)
        echo "Bitte werfen Sie Geld ein! Bier kostet 1,00€."
        ;;
      0,50)
        echo "Das ist zu wenig Geld! Bier kostet 0,50€ mehr.";;
      1,00)
        echo "Bier wird ausgegeben. Bitte nehmen Sie es danach aus der Ausgabe."
        state="FINISHED"
        ;;
      1,50)
        echo "Bier wird ausgegeben. Bitte nehmen Sie es danach aus der Ausgabe. Sie bekommen außerdem 0,50€ zurück."
        state="0,50"
        rueckgabe
        state="FINISHED"
        ;;
      2,00)
        echo "Bier wird ausgegeben. Bitte nehmen Sie es danach aus der Ausgabe. Sie bekommen außerdem 1,00€ zurück."
        state="1,00"
        rueckgabe
        state "FINISHED"
        ;;
      FINISHED)
        echo "Es ist noch ein Getränk in der Ausgabe. Bitte rausnehmen!"
        ;;
      *) echo "Was komisches ist passiert.";;
    esac
    ;;
   S)
    case $state in
      WAIT_FOR_COIN)
        echo "Bitte werfen Sie Geld ein! Schnaps kostet 1,50€."
        ;;
      0,50)
        echo "Das ist zu wenig Geld! Schnaps kostet 1,00€ mehr.";;
      1,00)
        echo "Das ist zu wenig Geld! Schnaps kostet 0,50€ mehr.";;
      1,50)
        echo "Schnaps wird ausgegeben. Bitte nehmen Sie ihn danach aus der Ausgabe."
        state="FINISHED"
        ;;
      2,00)
        echo "Schnaps wird ausgegeben. Bitte nehmen Sie ihn danach aus der Ausgabe. Sie bekommen außerdem 0,50€ zurück."
        state="0,50"
        rueckgabe
        state="FINISHED"
        ;;
      FINISHED)
        echo "Es ist noch ein Getränk in der Ausgabe. Bitte rausnehmen!"
        ;;
      *) echo "Was komisches ist passiert.";;
    esac
    ;;
   H)
    case $state in
      WAIT_FOR_COIN)
        echo "Bitte werfen Sie Geld ein! Headtrick kostet 2,00€."
        ;;
      0,50)
        echo "Das ist zu wenig Geld! Headtrick kostet 1,50€ mehr.";;
      1,00)
        echo "Das ist zu wenig Geld! Headtrick kostet 1,00€ mehr.";;
      1,50)
        echo "Das ist zu wenig Geld! Headtrick kostet 0,50€ mehr.";;
      2,00)
        echo "Headtrick wird ausgegeben. Bitte nehmen Sie ihn danach aus der Ausgabe."
        state "FINISHED"
        ;;
      FINISHED)
        echo "Es ist noch ein Getränk in der Ausgabe. Bitte rausnehmen!"
        ;;
      *) echo "Was komisches ist passiert.";;
    esac
    ;;
   "");;
   "exit") exit;;
   *) echo "Dieses Kommando ist leider falsch.";;
 esac
done
