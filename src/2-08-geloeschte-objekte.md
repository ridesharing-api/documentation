## Gelöschte Objekte {#geloeschte-objekte}

In der ridesharing.api **dürfen** Objekte **nicht** einfach gelöscht werden, sodass unter 
der betreffenden URL kein gültiges Objekt ausgeliefert wird. Stattdessen 
 wird ein sogenanntes _soft delete_ verwendet.

Hintergrund ist, dass ridesharing.api-Clients bei der Aktualisierung ihres
 Datenbestandes, z.B. mit den [Filtern](#filter) `modified_since` bzw. 
 `created_since`, erfahren können müssen, welche Objekte gelöscht wurden.

Dies wird durch die folgenden Regeln gewährleistet. 

Wenn ein Objekt gelöscht wird,

* **muss** das Objekt das zusätzliche Attribut `deleted` mit dem Wert
`true` bekommen
* **muss** das Attribut `modified` auf den Zeitpunkt der Löschung setzen
* **müssen** die Attribute `id`, `type` und `created` erhalten bleiben
* **dürfen** alle weiteren Attribute entfernt werden

Als HTTP-Statuscode **muss** weiterhin 200 verwendet werden.
