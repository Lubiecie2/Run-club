using Firebase.Auth;
using System;
using System.Threading.Tasks;
using Microsoft.Maui.Storage;

public class FirebaseAuthService
{
    private readonly FirebaseAuthProvider _authProvider;
    private readonly string _firebaseApiKey = "AIzaSyCsDhD2xRX1VODlfA-mXy0OJUGpqEJgTms";
    private FirebaseAuthLink _authLink;  // Przechowuje dane zalogowanego u�ytkownika

    // Konstruktor inicjalizuj�cy us�ug� Firebase
    public FirebaseAuthService()
    {
        _authProvider = new FirebaseAuthProvider(new FirebaseConfig(_firebaseApiKey));
    }

    // ------------------------------
    // Rejestracja nowego u�ytkownika
    // ------------------------------
    public async Task<string> RegisterWithEmailAndPasswordAsync(string email, string password)
    {
        try
        {
            // Tworzy nowego u�ytkownika
            _authLink = await _authProvider.CreateUserWithEmailAndPasswordAsync(email, password);

            // Zapisuje email do SecureStorage
            await SecureStorage.SetAsync("user_email", email);

            // Pobiera token Firebase
            string token = _authLink.FirebaseToken;
            return token; // Zwraca token, je�li rejestracja si� powiedzie
        }
        catch (FirebaseAuthException ex)
        {
            // Obs�uguje specyficzne b��dy Firebase
            return $"Error: {ex.Reason}";
        }
        catch (Exception ex)
        {
            // Obs�uguje og�lne b��dy
            return $"Error: {ex.Message}";
        }
    }

    // --------------------------
    // Logowanie istniej�cego u�ytkownika
    // --------------------------
    public async Task<string> SignInWithEmailAndPasswordAsync(string email, string password)
    {
        try
        {
            // Loguje u�ytkownika
            _authLink = await _authProvider.SignInWithEmailAndPasswordAsync(email, password);

            // Zapisuje email do SecureStorage
            await SecureStorage.SetAsync("user_email", email);

            // Pobiera token Firebase
            string token = _authLink.FirebaseToken;
            return token;
        }
        catch (Exception ex)
        {
            // Zwraca b��d, je�li logowanie nie powiedzie si�
            return $"Error: {ex.Message}";
        }
    }

    // --------------------------
    // Pobiera adres e-mail aktualnie zalogowanego u�ytkownika
    // --------------------------
    public string GetCurrentUserEmail()
    {
        return _authLink?.User.Email;  // Zwraca e-mail lub null, je�li u�ytkownik nie jest zalogowany
    }

    public async Task<string> GetCurrentUserEmailAsync()
    {
        var email = await SecureStorage.GetAsync("user_email");
        return email ?? "Nie jeste� zalogowany";  // Zwraca komunikat, je�li email jest pusty;  // Pobiera e-mail z SecureStorage
    }

    // --------------------------
    // Wylogowanie u�ytkownika
    // --------------------------
    public async Task LogoutAsync()
    {
        // Usuwa e-mail u�ytkownika z SecureStorage podczas wylogowania
        SecureStorage.Remove("user_email");
    }
}