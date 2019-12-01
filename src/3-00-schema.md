# Schema {#schema}

Dieses Kapitel beschreibt das Schema der ridesharing.api. Das Schema definiert
die Objekttypen und ihre Eigenschaften. Darüber hinaus ist im Schema
auch festgelegt, in welcher Beziehung verschiedene Objekttypen zu
einander stehen.

![ridesharing.api Objekttypen: Ein Überblick. Die Zahl an den Verbindungslinien entspricht der Anzahl der Attribute, die eine oder mehrere Verknüpfungen herstellen.](build/src/images/uml.svg){ width=100% }

## Die Objekte {#objekttypen}

Die ridesharing.api nutzt folgenden Objekte:

* ridesharing.api:System
* ridesharing.api:Route
* ridesharing.api:Trip
* ridesharing.api:Calendar
* ridesharing.api:CalendarException
* ridesharing.api:Stop
* ridesharing.api:Location
* ridesharing.api:SingleTrip
* ridesharing.api:SingleStop
* ridesharing.api:SingleLocation
* ridesharing.api:Person
* ridesharing.api:PersonContact
* ridesharing.api:Participation
* ridesharing.api:Preferences
* ridesharing.api:Car

Grundsätzlich muss jedes Objekt unter seiner ID abrufbar sein - auch dann, wenn
das Objekt in anderen Objekten intern ausgegeben wird. Bei der internen Ausgabe
wird beim internen Objekt auf die Rückreferenz auf das Elternobjekt verzichtet.

Als Beispiel hier eine Ausgabe von `ridesharing-api:Trip`, in welchem ein `ridesharing-api:Stop` enthalten
ist:

~~~~~  {#objekte_example1 .json}
{
    "id": "https://api.meine-mitfahrboerse.de/trip/123",
    "type": "https://schema.ridesharing-api.org/1.0/Trip",
    "created": "2019-02-07T18:28:18",
    "modified": "2019-03-14T15:09:26",
    "active": true,
    "seats": 3,
    "website": "https://meine-mitfahrboerse.de/trip/123",
    "route": "https://api.meine-mitfahrboerse.de/route/456",
    "stop": [
        {
            "id": "https://api.meine-mitfahrboerse.de/stop/789",
            "type": "https://schema.ridesharing-api.org/1.0/Stop",
            "created": "2019-02-07T18:28:18",
            "modified": "2019-03-14T15:09:26",
            "arrival": "10:00:00",
            "departure": "10:10:00",
            "location": {
                "id": "https://api.meine-mitfahrboerse.de/stop/012",
                "type": "https://schema.ridesharing-api.org/1.0/Location",
                "name": "Lyonesse Bahnhof"
            }
        },
        {
            "id": "https://api.meine-mitfahrboerse.de/stop/345",
            "type": "https://schema.ridesharing-api.org/1.0/Stop",
            "created": "2019-02-07T18:28:18",
            "modified": "2019-03-14T15:09:26",
            "arrival": "12:00:00",
            "departure": "12:10:00",
            "location": {
                "id": "https://api.meine-mitfahrboerse.de/stop/678",
                "type": "https://schema.ridesharing-api.org/1.0/Location",
                "name": "Atlantis Hafen"
            }
        },
        [...]
    ]
}
~~~~~

Das enthaltene `ridesharing-api:Stop` muss auch einzeln abgerufen werden können. Dabei kommt
dann das Eltern-Objekt als zusätzliches Attribut hinzu.:

~~~~~  {#objekte_example2 .json}
{
    "id": "https://api.meine-mitfahrboerse.de/stop/789",
    "type": "https://schema.ridesharing-api.org/1.0/Stop",
    "created": "2019-02-07T18:28:18",
    "modified": "2019-03-14T15:09:26",
    "arrival": "10:00:00",
    "departure": "10:10:00",
    "trip": "https://api.meine-mitfahrboerse.de/trip/123",
    "location": {
        "id": "https://api.meine-mitfahrboerse.de/stop/012",
        "type": "https://schema.ridesharing-api.org/1.0/Location",
        "name": "Lyonesse Bahnhof"
    }
}
~~~~~

Die im ersten Beispiel gezeigte Liste kann auch als Liste an URLs
geschrieben werden:

~~~~~  {#objekte_example3 .json}
{
    "id": "https://api.meine-mitfahrboerse.de/trip/123",
    "type": "https://schema.ridesharing-api.org/1.0/Trip",
    "created": "2019-02-07T18:28:18",
    "modified": "2019-03-14T15:09:26",
    "active": true,
    "seats": 3,
    "website": "https://meine-mitfahrboerse.de/trip/123",
    "route": "https://api.meine-mitfahrboerse.de/route/456",
    "stop": [
        "https://api.meine-mitfahrboerse.de/stop/789",
        "https://api.meine-mitfahrboerse.de/stop/345",
        [...]
    ]
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
