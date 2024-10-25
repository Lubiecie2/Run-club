using Firebase.Auth;
using System;
using System.Threading.Tasks;

    public class FirebaseAuthService
    {
        private readonly FirebaseAuthProvider _authProvider;
        private readonly string _firebaseApiKey = "AIzaSyCsDhD2xRX1VODlfA-mXy0OJUGpqEJgTms"; 

        public FirebaseAuthService()
        {
            _authProvider = new FirebaseAuthProvider(new FirebaseConfig(_firebaseApiKey));
        }

        public async Task<string> RegisterWithEmailAndPasswordAsync(string email, string password)
        {
            try
            {
                // Register a new user with email and password
                var auth = await _authProvider.CreateUserWithEmailAndPasswordAsync(email, password);

                // Get Firebase Token for the registered user
                string token = auth.FirebaseToken;

                return token; // Return token if successful
            }
            catch (FirebaseAuthException ex)
            {
                // Handle Firebase-specific errors
                return $"Error: {ex.Reason}";
            }
            catch (Exception ex)
            {
                // Handle general errors
                return $"Error: {ex.Message}";
            }
        }
    public async Task<string> SignInWithEmailAndPasswordAsync(string email, string password)
    {
        try
        {
            // Authenticate user with Firebase
            var auth = await _authProvider.SignInWithEmailAndPasswordAsync(email, password);
            string token = auth.FirebaseToken;  // Get Firebase token
            return token;
        }
        catch (Exception ex)
        {
            return $"Error: {ex.Message}";  // Return error if authentication fails
        }
    }

}