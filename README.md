# Series Example (Each Request Must Wait / Synchronous)
```
const myHeaders = new Headers();
myHeaders.append("otcsticket", "7cb4206a54c6b56b0d3c463005edc4ce9df6e08cf6f33f9d5b3268394eccb171082678f0f0697a786b04b90a54a8240e79b74d9bc1fc701b562a449cb26b37ff");

const formdata = new FormData();
formdata.append("chunkFile", fileInput.files[0], "/C:/chunking/SX Object Importer - Deployment Guide.docx.part3");
formdata.append("isFinal", "true");
formdata.append("guid", "e");
formdata.append("fileName", "SX Object Importer - Deployment Guide.docx");

const requestOptions = {
  method: "POST",
  headers: myHeaders,
  body: formdata,
  redirect: "follow"
};

fetch("http://localhost/otcs/cs.exe/api/v1/chunking/series", requestOptions)
  .then((response) => response.text())
  .then((result) => console.log(result))
  .catch((error) => console.error(error));
```

# Parallel Example (1. Send The Chunk File - Each Request Can Be Async)
```
const myHeaders = new Headers();
myHeaders.append("otcsticket", "7cb4206a54c6b56b0d3c463005edc4ce9df6e08cf6f33f9d5b3268394eccb171082678f0f0697a786b04b90a54a8240e79b74d9bc1fc701b562a449cb26b37ff");

const formdata = new FormData();
formdata.append("chunkFile", fileInput.files[0], "/C:/chunking/SX Object Importer - Deployment Guide.docx.part1");
formdata.append("guid", "a");
formdata.append("fileName", "SX Object Importer - Deployment Guide.docx");

const requestOptions = {
  method: "POST",
  headers: myHeaders,
  body: formdata,
  redirect: "follow"
};

fetch("http://localhost/otcs/cs.exe/api/v1/chunking/parallel", requestOptions)
  .then((response) => response.text())
  .then((result) => console.log(result))
  .catch((error) => console.error(error));
```

# Parallel Example (2. Notify The Server That The Chunking Upload Has Finished - Make Sure That All Chunking Upload Has Been Finished)
```
const myHeaders = new Headers();
myHeaders.append("otcsticket", "7cb4206a54c6b56b0d3c463005edc4ce9df6e08cf6f33f9d5b3268394eccb171082678f0f0697a786b04b90a54a8240e79b74d9bc1fc701b562a449cb26b37ff");

const formdata = new FormData();
formdata.append("guid", "a");
formdata.append("fileName", "SX Object Importer - Deployment Guide.docx");

const requestOptions = {
  method: "POST",
  headers: myHeaders,
  body: formdata,
  redirect: "follow"
};

fetch("http://localhost/otcs/cs.exe/api/v1/chunking/parallel/notify", requestOptions)
  .then((response) => response.text())
  .then((result) => console.log(result))
  .catch((error) => console.error(error));
```
