import { serve } from "https://deno.land/std@0.131.0/http/server.ts"


interface IIpify {
  ip: string
}

async function fetchIp(headers: Headers): Promise<IIpify>{
  const request = await fetch("https://api64.ipify.org?format=json", {
    headers
  });
  const asJson: IIpify = await request.json();


  return asJson;
}

serve(async (req) => {
  const ip = await fetchIp(req.headers);



  return new Response(
    JSON.stringify(ip),
    { headers: { "Content-Type": "application/json" } },
  )
})

