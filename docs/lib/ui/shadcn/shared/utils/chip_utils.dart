bool isChipUnicode(int codeUnit) {
  return codeUnit >= _chipStart && codeUnit <= _chipEnd;
}

bool isChipCharacter(String character) {
  if (character.isEmpty) return false;
  return isChipUnicode(character.codeUnitAt(0));
}

const int _chipStart = 0xE000;
const int _chipEnd = 0xF8FF;
