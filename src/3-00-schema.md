# Schema {#schema}

Dieses Kapitel beschreibt das Schema der ridesharing.api. Das Schema definiert
die Objekttypen und ihre Eigenschaften. Darüber hinaus ist im Schema
auch festgelegt, in welcher Beziehung verschiedene Objekttypen zu
einander stehen.

![ridesharing.api Objekttypen: Ein Überblick. Die Zahl an den Verbindungslinien entspricht der Anzahl der Attribute, die eine oder mehrere Verknüpfungen herstellen.](build/src/images/objekttypen_graph.png){ width=100% }

## Die Objekte {#objekttypen}

Die ridesharing.api nutzt folgenden Objekte:

* ridesharing.api:System
* ridesharing.api:Trip
* ridesharing.api:Person
* ridesharing.api:Car
* ridesharing.api:Participation
* ridesharing.api:Stop
* ridesharing.api:Location
* ridesharing.api:Preferences

Grundsätzlich muss jedes Objekt unter seiner ID abrufbar sein - auch dann, wenn
das Objekt in anderen Objekten intern ausgegeben wird. Bei der internen Ausgabe
wird beim internen Objekt auf die Rückreferenz auf das Elternobjekt verzichtet.

Als Beispiel hier eine Ausgabe von `ridesharing-api:Trip`, in welchem ein `ridesharing-api:Stop` enthalten
ist:

~~~~~  {#objekte_example1 .json}
{
}
~~~~~

Das enthaltene `ridesharing-api:Stop` muss auch einzeln abgerufen werden können. Dabei kommt
dann das Eltern-Objekt als zusätzliches Attribut hinzu.:

~~~~~  {#objekte_example2 .json}
{
}
~~~~~

Das zusätzliche Attribut ist ein Array, da es auch möglich ist, dass Fahrzeuge
von mehreren Hauptobjekten aus genutzt werden. Das kann z.B. bei `ridesharing-api:Car`
vorkommen:

~~~~~  {#objekte_example2 .json}
{
}
~~~~~


## Übergreifende Aspekte {#uebergreifende-aspekte}

### Vollständigkeit {#schema-vollstaendigkeit}

Alle regulär öffentlich abrufbaren Informationen **sollten** auch in der ridesharing.api
ausgegeben werden, solange dies nicht den Datenschutzbestimmungen widerspricht.
Daher sind sämtliche Felder im Schema als **empfohlen** zu behandeln, wenn
nicht explizit etwas anderes angegeben wurde.

### Herstellerspezifische Erweiterungen {#herstellerspezifische-erweiterungen}

In der ridesharing.api können zusätzliche, herstellerspezifische Eigenschaften hinzugefügt werden.
Dazu wird diesen Eigenschaften ein Herstellerprefix vorangestellt. So könnte man z.B.
`ridesharing-api:Location` um einen Point of Interest erweitern:

~~~~~
"BeispielHersteller:pointOfInterest": "Altes Stadttor",
~~~~~

### URL-Pfade in den Beispielen {#url-pfade-in-den-beispielen}

ridesharing.api-Clients wissen nichts vom Aufbau von Pfaden innerhalb von URLs,
müssen dies nicht wissen, und es gibt deshalb in der ridesharing.api-Spezifikation
keine Festlegungen dazu. Die in den Beispielen verwendeten URLs zeigen einen
möglichen Weg zur Umsetzungen der Empfehlungen in URLs.
