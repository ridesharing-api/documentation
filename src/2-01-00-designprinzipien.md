## Designprinzipien {#designprinzipien}

### Aufbauen auf gängiger Praxis {#aufbauen-auf-gaengiger-praxis}

Grundlage für die Erarbeitung der ridesharing.api-Spezifikation in der vorliegenden Version
ist eine Analyse von aktuell (2018 - 2019) in Deutschland etablierten
Ridesharing-Angeboten. Erklärtes Ziel für diese erste
Version ist es, mit möglichst geringem Entwicklungsaufwand auf Seite der Plattformanbieter.
Für die ridesharing.api-Spezifikation wurde sozusagen ein Datenmodell als "gemeinsamer Nenner"
auf Basis der gängigen Praxis konstruiert.

### Verbesserung gegenüber dem Status Quo wo möglich {#verbesserung-gegenueber-status-quo}

Dort, wo es dem Ziel der einfachen Implementierbarkeit und der einfachen Migration
nicht im Weg steht, erlauben sich die Autoren dieser Spezifikation, auch Funktionen
aufzunehmen, die noch nicht als gängige Praxis im Bereich der Ridesharing-Plattformen
bezeichnet werden können oder welche nur von einzelnen Systemen unterstützt werden.
Solche Funktionen sind dann so integriert, dass sie nicht als zwingende Anforderung
gelten.

Als Beispiel wäre die Fähigkeit zu Websocket-basierten Live-Updates zu nennen.
Diese sind nicht verpflichtend, sind aber eine sinnvolle Erweiterung, die mit demselben
Datenmodell realisierbar sind.

### Selbstbeschreibungsfähigkeit {#selbstbeschreibungsfaehigkeit}

Ausgaben des Servers sollten so beschaffen sein, dass sie für menschliche Nutzerinnen
weitgehend selbsterklärend sein können. Dies betrifft besonders die Benennung von
Objekten und Objekteigenschaften.

Um den Kreis der Entwicklerinnen und Entwickler, die mit einer ridesharing.api
arbeiten können, nicht unnötig einzuschränken, wird hierbei grundsätzlich und
soweit sinnvoll auf englischsprachige Begrifflichkeiten gesetzt.

### Erweiterbarkeit {#erweiterbarkeit}

Implementierer sollen in der Lage sein, über eine ridesharing.api-konforme Schnittstelle auch
solche Informationen auszugeben, die nicht im Rahmen des ridesharing.api-Schemas abgebildet werden
können. Dies bedeutet zum einen, dass ein System Objekttypen unterstützen und ausliefern
darf, die nicht (oder noch nicht) im ridesharing.api-Schema beschrieben sind. Das bedeutet auch,
dass Objekttypen so um eigene Eigenschaften erweitert werden können, die nicht im ridesharing.api
Schema beschrieben sind.

Ein weiterer Aspekt betrifft die Abwärtskompatibilität, also die Kompatibilität von
ridesharing.api-Clients mit zukünftigen Schnittstellen. So können beispielsweise zukünftige Erweiterungen
des ridesharing.api-Schemas, etwa um neue Objekttypen, genauso durchgeführt werden, wie die Erweiterungen
um herstellerspezifische Objekttypen. Ein Client muss diese Anteile nicht auswerten, sofern
sie nicht für die Aufgabe des Clients relevant sind. Es bedeutet im Umkehrschluss allerdings auch, dass ein Client
nicht fehlschlagen darf, falls derartige Erweiterungen vorhanden sind.


### Browseability/Verlinkung {#browseability_verlinkung}

Klassische Webservice-Schnittstellen erfordern von den Entwicklern vollständige Kenntnis
der angebotenen Einstiegspunkte und Zugriffsmethoden, gepaart mit sämtlichen unterstützten
URL-Parametern, um den vollen Funktionsumfang der Schnittstelle ausschöpfen zu können.

Ridesharing-Angebote sind weitgehend in Form von Graphen aufgebaut. Das bedeutet, dass
Objekte häufig mit einer Vielzahl anderer Objekte verknüpft sind. So hat eine Fahrt mehrere
Stops, an denen Personen in Form einer Participation ein- oder aussteigen. Gleichzeitig können
Personen Autos besitzen, die wiederum bei mehreren angebotenen Fahrten eingesetzt werden.

Eine ridesharing.api-Schnittstelle gibt jedem einzelnen Objekt eine eindeutige Adresse, eine URL.
Somit kann die Schnittstelle den Verweis von einem Objekt, beispielsweise einem Gremium,
auf ein anderes Objekt, etwa ein Mitglied des Gremiums, dadurch ausgeben, dass im Kontext
des Gremiums die URL des Mitglieds ausgeben wird. Der Client kann somit ausgehend von einem
bestimmten Objekt die zugehörigen Objekte im System finden, indem er einfach den angebotenen
URLs folgt. Dieses Prinzip wird auch "Follow Your Nose"^[<http://patterns.dataincubator.org/book/follow-your-nose.html>] genannt.
