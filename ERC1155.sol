pragma solidity ^0.5.0;

import "./SafeMath.sol";
import "./Address.sol";
import "./Common.sol";
import "./IERC1155TokenReceiver.sol";
import "./IERC1155.sol";

contract ERC1155 is IERC1155, ERC165, CommonConstants
{
    using SafeMath for uint256;
    using Address for address;

    // id => (owner => balance)
    mapping (uint256 => mapping(address => uint256)) internal balances;

    // owner => (operator => approved)
    mapping (address => mapping(address => bool)) internal operatorApproval;

bytes4 constant private INTERFACE_SIGNATURE_ERC165 = 0x01ffc9a7;

    /*
        bytes4(keccak256("safeTransferFrom(address,address,uint256,uint256,bytes)")) ^
        bytes4(keccak256("safeBatchTransferFrom(address,address,uint256[],uint256[],bytes)")) ^
        bytes4(keccak256("balanceOf(address,uint256)")) ^
        bytes4(keccak256("balanceOfBatch(address[],uint256[])")) ^
        bytes4(keccak256("setApprovalForAll(address,bool)")) ^
        bytes4(keccak256("isApprovedForAll(address,address)"));
    */
    bytes4 constant private INTERFACE_SIGNATURE_ERC1155 = 0xd9b67a26;

    function supportsInterface(bytes4 _interfaceId)
    public
    view
    returns (bool) {
         if (_interfaceId == INTERFACE_SIGNATURE_ERC165 ||
             _interfaceId == INTERFACE_SIGNATURE_ERC1155) {
            return true;
         }

         return false;
    }
