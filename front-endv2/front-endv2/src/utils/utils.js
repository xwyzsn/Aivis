export function ExtractData(data, key1, key2)
{
  let x = []
  let y = []
  for(let i=0;i<data.length;i++)
  {
    x.push(data[i][key1])
    y.push(data[i][key2])
  }
  return {'x':x,'y':y}
}

export function decodeURLParam(search){
  return JSON.parse('{"' + decodeURI(search).replace(/"/g, '\\"').replace(/&/g, '","').replace(/=/g,'":"') + '"}')
}