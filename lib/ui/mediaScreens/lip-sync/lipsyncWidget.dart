import 'package:flutter/material.dart';

class LipSyncWidget extends StatelessWidget {
  final String text;

  LipSyncWidget({required this.text});
  final Map<String, String> imageMap = {
    "A": "lib/assests/images/lip-sync Images/A_E_I.png",
    "B": "lib/assests/images/lip-sync Images/B_M_P.png",
    "C": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "D": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "E": "lib/assests/images/lip-sync Images/A_E_I.png",
    "F": "lib/assests/images/lip-sync Images/F_V.png",
    "G": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "H": "lib/assests/images/lip-sync Images/TH.png",
    "I": "lib/assests/images/lip-sync Images/A_E_I.png",
    "J": "lib/assests/images/lip-sync Images/CH_J_SH.png",
    "K": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "L": "lib/assests/images/lip-sync Images/L.png",
    "M": "lib/assests/images/lip-sync Images/B_M_P.png",
    "N": "lib/assests/images/lip-sync Images/N.png",
    "O": "lib/assests/images/lip-sync Images/O.png",
    "P": "lib/assests/images/lip-sync Images/B_M_P.png",
    "Q": "lib/assests/images/lip-sync Images/Q_W.png",
    "R": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "S": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "T": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "U": "lib/assests/images/lip-sync Images/U.png",
    "V": "lib/assests/images/lip-sync Images/F_V.png",
    "W": "lib/assests/images/lip-sync Images/Q_W.png",
    "X": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "Y": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "Z": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "CH": "lib/assests/images/lip-sync Images/CH_J_SH.png",
    "SH": "lib/assests/images/lip-sync Images/CH_J_SH.png",
    "TH": "lib/assests/images/lip-sync Images/TH.png",
    "a": "lib/assests/images/lip-sync Images/A_E_I.png",
    "b": "lib/assests/images/lip-sync Images/B_M_P.png",
    "c": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "d": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "e": "lib/assests/images/lip-sync Images/A_E_I.png",
    "f": "lib/assests/images/lip-sync Images/F_V.png",
    "g": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "h": "lib/assests/images/lip-sync Images/TH.png",
    "i": "lib/assests/images/lip-sync Images/A_E_I.png",
    "j": "lib/assests/images/lip-sync Images/CH_J_SH.png",
    "k": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "l": "lib/assests/images/lip-sync Images/L.png",
    "m": "lib/assests/images/lip-sync Images/B_M_P.png",
    "n": "lib/assests/images/lip-sync Images/N.png",
    "o": "lib/assests/images/lip-sync Images/O.png",
    "p": "lib/assests/images/lip-sync Images/B_M_P.png",
    "q": "lib/assests/images/lip-sync Images/Q_W.png",
    "r": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "s": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "t": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "u": "lib/assests/images/lip-sync Images/U.png",
    "v": "lib/assests/images/lip-sync Images/F_V.png",
    "w": "lib/assests/images/lip-sync Images/Q_W.png",
    "x": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "y": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "z": "lib/assests/images/lip-sync Images/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "ch": "lib/assests/images/lip-sync Images/CH_J_SH.png",
    "sh": "lib/assests/images/lip-sync Images/CH_J_SH.png",
    "th": "lib/assests/images/lip-sync Images/TH.png",
  };

  @override
  Widget build(BuildContext context) {
    List<String> letters = text.split('');

    return Container(
      color: Colors.black,
      height: 250,
      width: 300,
      child: ListView.builder(
        itemCount: letters.length,
        itemBuilder: (context, index) {
          return Container(
            height: 250,
            width: 300,
            child: Image.asset(
              getImagePath(letters[index]),
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }

  String getImagePath(String letter) {
    // Lookup the image path in the image map
    String? imagePath = imageMap[letter.toUpperCase()];
    // Return a default path if the letter is not found (you can handle this differently if needed)
    return imagePath ?? 'lib/assests/images/lip-sync Images/TH.png';
  }
}
