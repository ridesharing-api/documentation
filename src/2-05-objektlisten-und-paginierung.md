## Objektlisten und Paginierung {#objektlisten-und-paginierung}

Oft wird für ein Attribut kein Wert ausgegeben, sondern ein anderes Objekt oder
eine Liste von Objekten. Dabei kann eine Referenz auf das Objekt bzw. die
Objektliste angegeben werden, oder das Objekt bzw. die Objektlist wird intern
ausgegeben. Beide Verfahren sollen im Folgenden erklärt werden.
Zu beachten ist, dass für jedes Listenattribut festgelegt ist, welches dieser
Verfahren jeweils zu verwenden ist. Diese Information ist den
[Schemadefinitionen](#schema) zu entnehmen.

### Referenzierung von Objekten via URL

Bei der Referenzierung einzelner Objekte wird eine URL angegeben, welche auf
das entsprechende Objekt verweist. Der Typ ist hierbei ein
`string (url: Objekt-ID)`.
Ein Beispiel hierfür ist `` in ``:

~~~~~  {#objektlisten_ex1 .json}
{
}
~~~~~

Es kann auch eine Liste von Referenzen ausgegeben werden. Der Typ ist in diese
Fall `array of string (url: Objekt-ID)`.

Ein Beispiel hierfür ist `` in ``:

~~~~~  {#objektlisten_ex2 .json}
{
}
~~~~~

### Interne Ausgabe von Objekten

Objekte können auch intern ausgegeben werden. Dabei wird das gesamte Objekt als
Wert eines Attributs angegeben. Ein Beispiel für ein internes Objekt ist
`trip` in `ridesharing-api:System`:

~~~~~  {#objektlisten_ex3 .json}
~~~~~

Ebenso kann eine Liste von Objekten intern ausgegeben werden. Hier das
Beispiel des Attributes `stop` in `ridesharing-api:Trip`.

~~~~~  {#objektlisten_ex4 .json}
{
}
~~~~~

Bei der internen Ausgabe von Objekten **darf** der Server keine gelöschten
Objekte ausgeben.

### Externe Objektlisten

Es können auch Referenzen zu sogenannten externen Objektlisten angegeben werden.
Die externe Liste enthält dann die betreffenden Objekte in Form einer
Listenausgabe. Ein Beispiel dafür ist `trips` in `ridesharing-api:System`.

`ridesharing-api:System`:

~~~~~  {#objektlisten_ex5a .json}
{
}
~~~~~

Die externe Objektliste:

~~~~~  {#objektlisten_ex5b .json}
{
    "data": [
      
    ],
    ...
}
~~~~~


### Paginierung  {#paginierung}

Für externe Objektlisten ist eine Aufteilung sogenannte *Listenseiten*
vorgesehen, wobei jede Listenseite eine eigene URL erhält. Das dient dazu,
die bei der jeweiligen Anfrage übertragenen Datenmengen und Antwortzeiten zu
begrenzen.

Die Entscheidung, ob eine externe Objektliste mit Paginierung
ausgegeben wird, liegt allein beim Server. Bei Listen mit mehr als 100
Einträgen wird dies **empfohlen**.

Ein Server **muss** für eine stabile Sortierung von Listeneinträgen sorgen. Das
heißt, dass die Sortierung der Einträge einem konstanten Prinzip folgt und sich
nicht von Abfrage zu Abfrage ändert. Das kann z.B. durch die Sortierung von
Objekten nach einer eindeutigen und unveränderlichen ID erreicht werden.

Jede Listenseite **muss** die Attribute folgenden Attribute enthalten:

- **data** (Array der intern ausgegebenen Objekte)

- **pagination** (Object)

- **links** (Object)

Für `pagination` sind die folgenden Attribute festgelegt, die alle **optional**
sind:

- `totalElements`: Gibt die Gesamtanzahl der Objekte in der Liste an. Diese Zahl
kann sich unter Umständen bis zum Aufruf der nächsten Listenseiten ändern.

- `elementsPerPage`: Gibt die Anzahl der Objekte pro Listenseite an. Dieser Wert
muss auf allen Listenseiten bis auf die letzte gleich sein.

- `currentPage`: Gibt die aktuelle Seitenzahl in der Liste an.

- `totalPages`: Gibt die Gesamtanzahl der Seiten in der Liste an.

Für `links`  sind folgende Attribute festgelegt, die bis auf `next` alle
**optional** sind:

- `first`: URL der ersten Listenseite

- `prev`: URL der vorherigen Listenseite

- `self`: Die kanonische URL dieser Listenseite

- `next`: URL der nächsten Listen. Für alle Seiten bis auf die letzte ist die
Angabe dieser URL **zwingend**.

- `last`: URL der letzten Listenseite

~~~~~  {#paginierung_ex1 .json}
{
    "data": [
        {...},
        {...},
        ...
    ],
    "pagination": {
        "totalElements": 50000,
        "elementsPerPage": 100,
        "currentPage": 3,
        "totalPages":500
    },
    "links": {
        "first": "https://ridesharing.example.org/trips/",
        "prev": "https://ridesharing.example.org/trips/?page=2",
        "self": "https://ridesharing.example.org/trips/?page=3",
        "next": "https://ridesharing.example.org/trips/?page=4",
        "last": "https://ridesharing.example.org/trips/?page=500",
    }
}
~~~~~

### Filter  {#filter}

Externe Objektlisten können mit den URL-Parametern `created_since`, `created_until`,
`modified_since` und `modified_until` eingeschränkt werden. Diese Parameter
beziehen sich auf die entsprechenden Attribute der jeweiligen Objekte, wobei
reservierte Zeichen URL-Kodiert werden müssen. Ein Server muss diese Parameter
bei allen externen Objektlisten unterstützen.

Die Filter werden vom Client benutzt, indem die gewünschten URL-Parameter an
die URL der ersten Listenseite angehängt werden. Bei allen weiteren Seiten,
genauer gesagt bei den Werten von `links`, **muss** der Server sicherzustellen,
dass die verwendeten Filter erhalten bleiben.

Ein Server **muss** für den im nächsten Abschnitt beschrieben
Aktualisierungsmechanismus auch die den Filtern entsprechenden gelöschten
Objekte ausgeben, wenn der Parameter `modified_since` gesetzt ist.
 Wenn `modified_since` nicht gesetzt ist,
dann **dürfen** die gelöschten Objekte **nicht** ausgegeben werden.
Dadurch kann sich ein Client effizient darüber informieren, welche der Objekte
in seinem lokalen Bestand gelöscht wurden.

Lautet die URL für eine Liste von Drucksachen wie folgt:

    https://ridesharing.example.org/trips/

kann der Client die folgende URL bilden, um die Ausgabe der Liste auf
Drucksachen einzuschränken, die seit dem 1. Januar 2014 veröffentlicht wurden:

    https://ridesharing.example.org/trips/?created_since=2014-01-01T00%3A00%3A00%2B01%3A00

Mehrere Parameter können auch gemeinsam verwendet werden. So kann man z.B. eine
Einschränkung vom 1.1.2014 bis zum 31.1.2014 vornehmen:

    https://ridesharing.example.org/trips/?created_since=2014-01-01T00%3A00%3A00%2B01%3A00&created_until=2014-01-31T23%3A59%3A59%2B01%3A00

Die genannten URL-Parameter erwarten grundsätzlich eine vollständige [`date-time`-Angabe](#datum_zeit).

Des Weiteren kann ein Client die Anzahl der Objekte pro Listenseite durch
den URL-Parameter `limit` begrenzen, der sich auf das gleichnamige
Attribut bezieht. Ein Client **darf nicht** erwarten, dass sich ein Server an
seine `limit`-Anfrage hält.

### Der Aktualisierungsmechanismus {#aktualisierungsmechanismus}

Der Hauptnutzen der Filter ist die Möglichkeit, einen lokalen Datenbestand
inkrementell zu aktualisieren.

Ein Client könnte z.B. am 1.1.2014 um 2:00 Uhr deutscher Zeit die Liste aller
Drucksachen herunterladen und in einer Datenbank speichern.

    https://ridesharing.example.org/trips/

Um den Datenbestand am nächsten Tag zu aktualisieren, ruft der Client dieselbe
URL auf, diesmal jedoch mit dem Parameter `modified_since` mit dem Wert
`2014-01-01T02:00:00+01:00` und mit `omit_internal`.

    https://ridesharing.example.org/trips/?modified_since=2014-01-01T02%3A00%3A00%2B01%3A00&omit_internal=true

Diese Liste ist in der Regel deutlich kürzer als die Liste aller Objekte,
sodass die Aktualisierung bedeutend schneller ist als der erste Abruf. Der
Client muss außerdem nur noch eine deutlich kleinere Menge an Objekten in die
Datenbank einfügen, aktualisieren oder löschen, um den gleichen Datenstand wie
der Server zu haben.