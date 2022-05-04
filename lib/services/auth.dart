import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:food_app/localdb.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

// SignIn Function
Future<User?> signInWithGoogle() async {
  // Signing with Google
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication? googleSignInAuthentication =
      await googleSignInAccount!.authentication;

  // Creating Credential for firebase
  final AuthCredential credential = GoogleAuthProvider.credential(
    idToken: googleSignInAuthentication?.idToken,
    accessToken: googleSignInAuthentication?.accessToken,
  );

  // Signing in with Credential & making a user in firebase and getting user class
  final UserCredential = await _auth.signInWithCredential(credential);
  final User? user = UserCredential.user;

  // Checking is on
  assert(!user!.isAnonymous);
  assert(await user!.getIdToken() != null);

  final User? currentUser = await _auth.currentUser;
  assert(currentUser?.uid == user!.uid);
  print(user);
  LocalDataSaver.saveLoginData(true);
  LocalDataSaver.saveName(user!.displayName.toString());
  LocalDataSaver.saveMail(user.email.toString());
  return user;
}
