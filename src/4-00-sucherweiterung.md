# Sucherweiterung {#sucherweiterung}

Die `ridesharing.api` ist konzipiert, um volle Datenbestände abzurufen und
aktuell zu halten. Hintergrund ist, dass nur mit dem Vorliegen aller Daten
wünschenswerte Features wie multimodales Routing umgesetzt werden können.
Daher wird empfohlen, immer diesen Weg bereitzustellen.

Da zum Beispiel aber bei Browserabfragen lediglich ein nutzerspezifisches
Subset an Informationen gebraucht wird, soll im Folgenden skiziert werden,
wie man leicht auf dem `ridesharing.api` Datenmodell Abfragen erstellen kann.

## Suchanfrage

In den allermeisten Fällen wird nach einem `SingleTrip` gesucht, da üblicherweise
eine spezifische Fahrt von A nach B gesucht wird. Darüber hinaus wird
im Fall von regelmäßigen Fahrten ein abstrakterer `Trip` gesucht. Die Suchanfragen
unterscheiden sich wie bei `SingleTrip` vs. `Trip` vor allem darin, dass
beim `SingleTrip` eine konkrete Abfahrtzeit gesucht wird, beim `Trip` dagegen
aber ein sich wiederholendes Muster wie z.B. "jeden Wochentag 7:00 Uhr". 

Unsere Such-API muss also für beide Basis-Objekte funktionieren, was angesichts
der Ähnlichkeit beider Objekte recht einfach ist.

Um eine Suche zu starten, muss ein mit den Wünschen des Anfragenden ausgefüllter
`Trip` bzw. `SingleTrip` an den Server gesendet werden. Relevant bei dieser 
Anfrage sind zudem die `Stop`s bzw. `SingleStop`s und ihre dazugehörigen
`Location` bzw `SingleLocation`.

Um alles in einen Request zu verpacken, wird die in Kapitel 2.5.3
dokumentierte interne Ausgabe von Objekten verwendet. Eine so aufgebaute
Suchanfrage sähe zum Beispiel also wie folgt aus:


~~~~~ {#search_request_1.json}
{
    "type": "https://schema.ridesharing-api.org/1.0/SingleTrip",
    "nonsmoking": true,
    "singleStop": [
        {
            "type": "https://schema.ridesharing-api.org/1.0/Stop",
            "departure": "2019-03-14T15:09:26",
            "singleLocation": {
                "streetAddress": "Am Geldspeicher 10",
                "postalCode": "12354",
                "locality": "Entenhausen"
            }
        },
        {
            "type": "https://schema.ridesharing-api.org/1.0/Stop",
            "singleLocation": {
                "streetAddress": "Am großen Pilz 5", 
                "postalCode": "54321",
                "locality": "Schlumpfhausen"
            }
        }
    ]
}
~~~~~

Ebenfalls möglich ist eine Suche über Längen- und Breitengrad:

~~~~~ {#search_request_1.json}
{
    "type": "https://schema.ridesharing-api.org/1.0/SingleTrip",
    "nonsmoking": true,
    "singleStop": [
        {
            "type": "https://schema.ridesharing-api.org/1.0/Stop",
            "departure": "2019-03-14T15:09:26",
            "singleLocation": {
                "geojson": {
                    "type": "Feature",
                    "geometry": {
                        "type": "Point",
                        "coordinates": [49, 09]
                    }
                }
            }
        },
        {
            "type": "https://schema.ridesharing-api.org/1.0/Stop",
            "singleLocation": {
                "geojson": {
                    "type": "Feature",
                    "geometry": {
                        "type": "Point",
                        "coordinates": [50, 10]
                    }
                }
            }
        }
    ]
}
~~~~~

Dieselbe Art der Anfrage ist auch auf `Trip` mäglich und lässt sich beliebig
durch Zusätze a la `Calendar` zur Definition von regelmäßigen Fahrten erweitern.

## Suchantwort

Eine Antwort auf eine Suchanfrage findet ebenfalls als Trip bzw SingleTrip
mit intern ausgegebenen Objekten statt. Da die Ausgabe zu 100% der normalen
`ridesharing.api` Ausgabe enstpricht, verzichten wir hier auf ein Beispiel.

Wenn mit der Suchabfrage mehrere Server abgefragt werden, so wird es zwangsweise
zu sehr unterschiedlichen Ergebnissen kommen: jeder Dienst wird eine andere
Form der Georeferenzierung und der Priorisierung haben. Diese zwangsweise 
auftretende Ungenauigkeit sollte beim Entwicklen berücksichtigt werden und 
als Empfehlung zum vollständigen Bereitstellen der Daten verstanden werden:
nur so lassen sich konsistente Suchergebnisse erzeugen.
