```markdown
# Visionect Server Home Assistant Addon

Ten addon umożliwia uruchomienie Visionect Software Suite (VSS) bezpośrednio w Home Assistant do sterowania wyświetlaczami e-ink takimi jak Joan 6.

## Instalacja

1. Dodaj to repozytorium do Home Assistant:
   - Idź do Supervisor -> Add-on Store
   - Kliknij na trzy kropki w prawym górnym rogu
   - Wybierz "Repositories"
   - Dodaj URL tego repozytorium

2. Znajdź "Visionect Server" w Add-on Store i zainstaluj

3. Skonfiguruj addon poprzez zakładkę Configuration

## Konfiguracja

### Podstawowe opcje:
- **architecture**: Wybierz architekturę (`auto`, `arm`, `x86_64`)
- **visionect_version**: Wersja serwera Visionect (domyślnie 7.6.5)
- **postgres_user**: Użytkownik bazy danych
- **postgres_password**: Hasło do bazy danych
- **postgres_db**: Nazwa bazy danych
- **server_address**: Adres serwera (dla urządzeń zewnętrznych)

### Konfiguracja Joan 6:

1. Uruchom addon
2. Przejdź do `http://homeassistant.local:8081`
3. Skonfiguruj swoje urządzenie Joan 6
4. W ustawieniach urządzenia zmień Backend na "HTTP - external renderer"
5. Wygeneruj API key i secret w sekcji Users
6. Użyj tych danych w swoich skryptach automatyzacji

## Rozwiązywanie problemów

### Joan 6 nie łączy się z serwerem:
- Sprawdź, czy porty 8081 i 11113 są dostępne
- Upewnij się, że urządzenie i Home Assistant są w tej samej sieci
- Sprawdź logi addonu w Home Assistant

### Problemy z uprawnieniami:
- Addon wymaga uprawnień privileged
- Sprawdź, czy `/dev/fuse` jest dostępny na hoście

### Problemy z architekturą:
- Jeśli `auto` nie działa, wybierz architekturę ręcznie
- Dla urządzeń ARM wybierz `arm`
- Dla komputerów x86/x64 wybierz `x86_64`

## Porty

- 8081: Interfejs webowy VSS
- 11113: Komunikacja z urządzeniami
- 5432: PostgreSQL (opcjonalnie zewnętrzny dostęp)
```