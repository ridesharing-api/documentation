## Eigenschaften mit Verwendung in mehreren Objekttypen {#eigenschaften-mit-verwendung-in-mehreren-objekttypen}

### `id` {#eigenschaft-id}

Die Eigenschaft `id` enthält den eindeutigen Bezeichner des Objekts, nämlich seine URL.
Dies ist ein **zwingendes** Merkmal für jedes Objekt.

### `type` {#eigenschaft-type}

Objekttypenangabe des Objekts, **zwingend** für jedes Objekt. Der Wert ist
eine Namespace-URL. Für die ridesharing.api-Objekttypen sind die folgenden URLs
definiert:

Typ (kurz)                          | Namespace-URL
------------------------------------|----------------------------------------------------
`ridesharing-api:Calendar`          |https://schema.ridesharing-api.org/1.0/Calendar
`ridesharing-api:CalendarException` |https://schema.ridesharing-api.org/1.0/CalendarException
`ridesharing-api:Car`               |https://schema.ridesharing-api.org/1.0/Car
`ridesharing-api:Location`          |https://schema.ridesharing-api.org/1.0/Location
`ridesharing-api:Participation`     |https://schema.ridesharing-api.org/1.0/Participation
`ridesharing-api:Person`            |https://schema.ridesharing-api.org/1.0/Person
`ridesharing-api:PersonContact`     |https://schema.ridesharing-api.org/1.0/PersonContact
`ridesharing-api:Preferences`       |https://schema.ridesharing-api.org/1.0/Preferences
`ridesharing-api:Route`             |https://schema.ridesharing-api.org/1.0/Route
`ridesharing-api:SingleLocation`    |https://schema.ridesharing-api.org/1.0/SingleLocation
`ridesharing-api:SingleStop`        |https://schema.ridesharing-api.org/1.0/SingleStop
`ridesharing-api:SingleTrip`        |https://schema.ridesharing-api.org/1.0/SingleTrip
`ridesharing-api:Stop`              |https://schema.ridesharing-api.org/1.0/Stop
`ridesharing-api:System`            |https://schema.ridesharing-api.org/1.0/System
`ridesharing-api:Trip`              |https://schema.ridesharing-api.org/1.0/Trip

### `created` {#eigenschaft-created}

Datum und Uhrzeit der Erstellung des jeweiligen Objekts.

Diese Eigenschaft **muss** in allen Objekttypen angegeben werden.

### `modified` {#eigenschaft-modified}

Diese Eigenschaft kennzeichnet stets Datum und Uhrzeit der letzten Änderung des
jeweiligen Objekts.

Diese Eigenschaft **muss** - genau wie `created` - in allen Objekttypen angegeben
werden.

Es ist **zwingend**, dass bei jeder Änderung eines Objekts der Wert dieses
Attributs auf die zu diesem Zeitpunkt aktuelle Uhrzeit gesetzt wird, da ein
Client in der Regel seinen Datenbestand nur auf Basis dieses Attributs
verlustfrei aktualisieren kann.

### `deleted` {#eigenschaft-deleted}

Falls das Objekt gelöscht wurde, muss dieses gemäß Kapitel 2.8 das Attribut
`deleted: true` bekommen.
