// craete a express server and serve static files from the 'public' directory
const express = require('express');
const path = require('path');
const app = express();
const PORT = process.env.PORT || 3000;
app.use(express.static(path.join(__dirname, 'public')));
app.get('/', (req, res) => {
  setTimeout(() => {
    console.log('Request received at root endpoint');
  }
  , 1000); // Simulate a delay of 1 second before logging

  console.log('Serving static files from the public directory');
  // Respond with a message
  res.setHeader('Content-Type', 'application/json');
  // Set a delay of 1 second before sending the response
  setTimeout(() => {
    console.log('Sending response after delay');
  }, 1000); // Simulate a delay of 1 second before sending the response
  // Send a JSON response
  console.log('Preparing to send response');
  console.log('Response sent successfully');
  console.log('Response headers set');
  console.log('Response body: Welcome to the Express server!');
  console.log('Response status code: 200');
  console.log('Response sent at: ' + new Date().toISOString());
  console.log('Request method: ' + req.method);
  console.log('Request URL: ' + req.url);
  console.log('Request headers: ', req.headers);
  console.log('Request query parameters: ', req.query);
  console.log('Request body: ', req.body);
  console.log('Request IP: ' + req.ip);
  console.log('Request protocol: ' + req.protocol);
  console.log('Request hostname: ' + req.hostname);
  console.log('Request original URL: ' + req.originalUrl);
  console.log('Request path: ' + req.path); 
  return res.status(200).json({
    message: 'Welcome to the Express server! Static files are being served from the public directory.'
  });
});
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});