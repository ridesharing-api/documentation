## Instanzierung

Ein wichtiger Aspekt im Datenstandard ist die Instanzierung. Damit ist
gemeint, dass auch Mitfahrbörsen ganz analog zum ÖPNV einen Soll- und 
einen Ist-Fahrtplan haben.

Die allermeisten Börsen haben zur Zeit nur einen Soll-Fahrplan, den 
Börsen ist meistens nicht bekannt, ob eine konkrete Fahrt wirklich 
stattfindet. Dafür hat ein relevanter Teil der Mitfahrangebote eine Art
Fahrtplan: die Fahrten finden nicht nur ein mal statt, sondern
regelmäßig. Im Falle einer regionalen Fahrt ist dies zum Beispiel
eine tägliche Fahrt zur Arbeit, im Falle einer überregionalen Fahrt
Wochenend-Pendler, die jedes Wochenende an einen anderen Ort fahren.

Die ridesharing.api bildet die Instanzierung über die Single*-Objekte
ab. `Trip`, `Stop` und `Location` repräsentieren den Soll-Fahrplan
und haben daher keine Festlegung auf ein Datum, sondern nur auf eine
Zeit und einen Rythmus. `SingleTrip`, `SingleStop` und `SingleLocation`
dagegen repräsentieren konkrete Fahrten und haben daher ein
exaktes Datum sowie exakte Uhrzeiten.

Durch die Verlinkung via `id`s können Update der instanzierten
Datensätze auch einzeln vorgenommen werden, so dass die Serverlast
gering gehalten werden kann.
