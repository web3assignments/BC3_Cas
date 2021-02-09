/*
You can use Play editor with any contract.
Paste it in the editor and wait for the preview to start interacting with it.

**To interact with the contract you will need a Metamask extension.
*/
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "./provableAPI.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PropertyContract is usingProvable,Ownable
{
    
  //Provable variablesS
  string  public addressAPICheck;
  uint256 public priceOfUrl;
  
 
  //Property class
  struct Property 
    {
        address ownerAddress;
        uint ID;   
        string location;
        uint cost;
    }
  
  // Total count of properties determines property ID, could use random instead.
  uint public totalPropertyCounter;
  
  // quicklist for look up owner of Property by ID, ID = index
  address[] public ownerList;
  
  //The events of a couple functions
  event transferPropertySucces(bool result); 
  event registerPropertySucces(bool result, uint ID);
   
  //mapping of the address to the array of properties
  mapping (address => Property[]) public propertiesMapping;
  
  //Functions for provable API call
  
   function __callback(bytes32 /* myid prevent warning*/ , string memory result ) override public {
       if (msg.sender != provable_cbAddress()) revert();
       addressAPICheck = result;
   }

   function getAPICheck(string memory _location) public payable {
       priceOfUrl = provable_getPrice("URL");
       require (address(this).balance >= priceOfUrl,"please add some ETH to cover for the query fee");
       string memory localTempStart = "json(https://api.data.amsterdam.nl/atlas/search/adres/?q=";
       string memory localTempEnd = ").count_hits";
       string memory localTemp = concatenate(localTempStart , _location,  localTempEnd);
       provable_query("URL", localTemp);
   }
   
   function concatenate(string memory a,string memory b,string memory c )public pure returns(string memory) {
            return string(abi.encodePacked(a, b , c));
        }


  //This function register a property for the sender.
  //Could add some authirization, who could register properties.
  function registerProperty(string memory _location, uint _cost) public
    {
        require(propertiesMapping[msg.sender].length < 10);
        totalPropertyCounter = totalPropertyCounter + 1;
        Property memory myproperty = Property(
           {
                ownerAddress: msg.sender,
                location: _location,
                cost: _cost,
                ID: totalPropertyCounter
            });
        propertiesMapping[msg.sender].push(myproperty);
        ownerList.push(msg.sender);
        bool result = true;
        emit registerPropertySucces(result, myproperty.ID);
  
	}
  
  //Transfer property. Push property to buyer , pop properrty from old owner.
  //Does the old owner transfers to the new owner?
  function transferProperty(address _Buyer, uint _ID) public
    {
        require(_Buyer != msg.sender);
        bool result = false;
        for(uint i=0; i < (propertiesMapping[msg.sender].length);i++)    
        {
            if (propertiesMapping[msg.sender][i].ID == _ID)
            {
                Property memory myproperty = Property(
                  {
                    ownerAddress:_Buyer,
                    location: propertiesMapping[msg.sender][i].location,
                    cost: propertiesMapping[msg.sender][i].cost,
                    ID: _ID
                  });
                //push property to mapping and remove from other mapping
                propertiesMapping[_Buyer].push(myproperty);   
                Property memory temp = propertiesMapping[msg.sender][i];
                uint arraySize = propertiesMapping[msg.sender].length;
                propertiesMapping[msg.sender][i] = propertiesMapping[msg.sender][arraySize-1];
                propertiesMapping[msg.sender][arraySize-1] = temp;
                propertiesMapping[msg.sender].pop();
                
                //change owner in quicklist
                ownerList[myproperty.ID]=_Buyer;
                result = true;                
            }
        }
        emit transferPropertySucces(result);                
    }
  
  //Returns property of certain index
  function getProperty(address _propertyHolder, uint _index) public view returns (string memory, uint, address,uint)
    {
        require(propertiesMapping[_propertyHolder].length >0 );
        return (propertiesMapping[_propertyHolder][_index].location, 
                propertiesMapping[_propertyHolder][_index].cost,
                propertiesMapping[_propertyHolder][_index].ownerAddress,
                propertiesMapping[_propertyHolder][_index].ID);
            
    }

  function getProperties() public view returns (Property[] memory)
  {
    require(propertiesMapping[msg.sender].length >0 );
    Property[] memory properties = propertiesMapping[msg.sender];
    return properties;
  }
  
  function getNoOfProperties(address __propertyHolder) public view returns (uint)
    {
        uint result = propertiesMapping[__propertyHolder].length;
        return result;
    }

//function only the owner can do. PD-12
   function deleteProperty(address __propertyHolder, uint _ID)public onlyOwner{
     Property memory temp = propertiesMapping[__propertyHolder][_ID];
                uint arraySize = propertiesMapping[__propertyHolder].length;
                propertiesMapping[__propertyHolder][_ID] = propertiesMapping[__propertyHolder][arraySize-1];
                propertiesMapping[__propertyHolder][arraySize-1] = temp;
                propertiesMapping[__propertyHolder].pop();

   }

}