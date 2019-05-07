## ridesharing.api Endpunkt

Als ridesharing.api Endpunkt bzw. Einsprungspunkt zur Schnittstelle wird ein `ridesharing.api:System`
Objekt genutzt. Falls auf einem HTTP-Host mehrere ridesharing.api-Schnittstellen oder
mehrere ridesharing.api Versionen parallel installiert sind, **müssen** diese eindeutige und
voneinander unabhängige ridesharing.api-Endpunkte anbieten. Es ist allerdings möglich,
eine Liste von `ridesharing.api:System`-Objekten auszugeben, die z.B. auf verschiedene
ridesharing.api-Versionen einer Schnittstelle verweisen.