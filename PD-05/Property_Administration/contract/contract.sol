/*
You can use Play editor with any contract.
Paste it in the editor and wait for the preview to start interacting with it.

**To interact with the contract you will need a Metamask extension.
*/

//pragma solidity 0.5.7;
pragma experimental ABIEncoderV2;



contract PropertyContract
{
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

  
  //The events of a couple functions
  event transferPropertySucces(bool result); 
  event registerPropertySucces(bool result);
   
  //mapping of the address to the array of properties
  mapping (address => Property[]) public propertiesMapping;

  //This function register a property for the sender.
  //Could add some authirization, who could register properties.
  function registerProperty(string memory _location, uint _cost) public
    {
        totalPropertyCounter = totalPropertyCounter + 1;
        Property memory myproperty = Property(
           {
                ownerAddress: msg.sender,
                location: _location,
                cost: _cost,
                ID: totalPropertyCounter
            });
        propertiesMapping[msg.sender].push(myproperty);
        bool result = true;
        emit registerPropertySucces(result);
  
	}
  
  //Transfer property. Push property to buyer , pop properrty from old owner.
  //Does the old owner transfers to the new owner?
  function transferProperty(address _Buyer, uint _ID) public returns (bool)
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
                propertiesMapping[_Buyer].push(myproperty);   
                Property memory temp = propertiesMapping[msg.sender][i];
                uint arraySize = propertiesMapping[msg.sender].length;
                propertiesMapping[msg.sender][i] = propertiesMapping[msg.sender][arraySize-1];
                propertiesMapping[msg.sender][arraySize-1] = temp;
                propertiesMapping[msg.sender].pop();
                result = true;                
            }
        }
        emit transferPropertySucces(result);                
        return result;
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

}