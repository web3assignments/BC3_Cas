/*
You can use Play editor with any contract.
Paste it in the editor and wait for the preview to start interacting with it.

**To interact with the contract you will need a Metamask extension.
*/


///pragma solidity 0.5.7;


contract PropertyContract
{
	
  struct Property 
    {
        address ownerAddress;
        string location;
        uint cost;
        uint ID;   
    }

	uint public totalPropertyCounter;

   
  
	mapping (address => Property[]) public propertiesMapping;
  
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
  
	}
  
  function transferProperty(address _Buyer, uint _ID) public returns (bool)
    {
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
                
                delete propertiesMapping[msg.sender][i];                
                return true;
            }
        }
        return false;
    }
  
  function getProperties(address _propertyHolder, uint _index) public returns (string memory, uint, address,uint)
    {
        return (propertiesMapping[_propertyHolder][_index].location, 
                propertiesMapping[_propertyHolder][_index].cost,
                propertiesMapping[_propertyHolder][_index].ownerAddress,
                propertiesMapping[_propertyHolder][_index].ID);
    }
  
  function getNoOfProperties(address __propertyHolder) public returns (uint)
    {
        return propertiesMapping[__propertyHolder].length;
    }
  
  

}