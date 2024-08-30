// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:webcrypto/webcrypto.dart';

// Future<JsonWebKeyPair> generateKeys() async {
//   final keyPair = await EcdhPrivateKey.generateKey(EllipticCurve.p256);
//   final publicKeyJwk = await keyPair.publicKey.exportJsonWebKey();
//   final privateKeyJwk = await keyPair.privateKey.exportJsonWebKey();

//   return JsonWebKeyPair(
//     privateKey: json.encode(privateKeyJwk),
//     publicKey: json.encode(publicKeyJwk),
//   );
// }

// // Model class for storing keys
// class JsonWebKeyPair {
//   const JsonWebKeyPair({
//     required this.privateKey,
//     required this.publicKey,
//   });

//   final String privateKey;
//   final String publicKey;
// }




// // SendersJwk -> sender.privateKey
// // ReceiverJwk -> receiver.publicKey
// Future<List<int>> deriveKey(String senderJwk, String receiverJwk) async {
//   // Sender's key
//   final senderPrivateKey = json.decode(senderJwk);
//   final senderEcdhKey = await EcdhPrivateKey.importJsonWebKey(
//     senderPrivateKey,
//     EllipticCurve.p256,
//   );

//   // Receiver's key
//   final receiverPublicKey = json.decode(receiverJwk);
//   final receiverEcdhKey = await EcdhPublicKey.importJsonWebKey(
//     receiverPublicKey,
//     EllipticCurve.p256,
//   );

//   // Generating CryptoKey
//   final derivedBits = await senderEcdhKey.deriveBits(256, receiverEcdhKey);
//   return derivedBits;
// }



// // The "iv" stands for initialization vector (IV). To ensure the encryption’s strength,
// // each encryption process must use a random and distinct IV.
// // It’s included in the message so that the decryption procedure can use it.
// final Uint8List iv = Uint8List.fromList('Initialization Vector'.codeUnits);


// Future<String> encryptMessage(String message, List<int> deriveKey) async {
//   // Importing cryptoKey
//   final aesGcmSecretKey = await AesGcmSecretKey.importRawKey(deriveKey);

//   // Converting message into bytes
//   final messageBytes = Uint8List.fromList(message.codeUnits);

//   // Encrypting the message
//   final encryptedMessageBytes =
//       await aesGcmSecretKey.encryptBytes(messageBytes, iv);

//   // Converting encrypted message into String
//   final encryptedMessage = String.fromCharCodes(encryptedMessageBytes);
//   return encryptedMessage;
// }


// Future<String> decryptMessage(String encryptedMessage, List<int> deriveKey) async {
//   // Importing cryptoKey
//   final aesGcmSecretKey = await AesGcmSecretKey.importRawKey(deriveKey);

//   // Converting message into bytes
//   final messageBytes = Uint8List.fromList(encryptedMessage.codeUnits);

//   // Decrypting the message
//   final decryptedMessageBytes =
//       await aesGcmSecretKey.decryptBytes(messageBytes, iv);

//   // Converting decrypted message into String
//   final decryptedMessage = String.fromCharCodes(decryptedMessageBytes);
//   return decryptedMessage;
// }

/**
 * 
 * 
 * 
 
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

String privateKeyString="key goes here";
String publicKeyString="key goes here";

//create a instance of RSA key praser    
RSAKeyParser keyParser = RSAKeyParser();

//and parse those string keys
RSAAsymmetricKey privateKeyParser = keyParser.parse(privateKeyString);
RSAAsymmetricKey publicKeyParser =keyParser.parse(publicKeyString);

final publicKey = RSAPublicKey(publicKeyParser.modulus!, publicKeyParser.exponent!);
final privKey;

if (privateKeyParser is RSAPrivateKey) {

privKey = RSAPrivateKey(privateKeyParser.modulus!,privateKeyParser.exponent!, privateKeyParser.p,privateKeyParser.q);
final plainText = 'hello world';

final encrypter = Encrypter(RSA(publicKey: publicKey, privateKey:privKey));

final encrypted = encrypter.encrypt(plainText);
final decrypted = encrypter.decrypt(encrypted);

}


 */



import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';

class EncryptionClass{

  static final key = encrypt.Key.fromUtf8('4f1aaae66406e358');
  static final iv = encrypt.IV.fromUtf8('df1e180949793972');
  static final encrypter = encrypt.Encrypter(encrypt.AES(key,mode:encrypt.AESMode.cbc));
  // static final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: "PKCS7"));


    static  String  encryption(String text){
      final encryptedText = encrypter.encrypt(text,iv: iv);

      return encryptedText.base64;

    }


    static String decryption(String text){
        return encrypter.decrypt64(text,iv: iv);
    }
}