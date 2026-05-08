//
// test.js
//
#!/usr/bin/env node

/**
 * Simple test suite for Hello World application
 */

const http = require('http');

// Test configuration
const TEST_PORT = 3001;
const TEST_HOST = 'localhost';

// Import the server (but don't start it yet)
process.env.PORT = TEST_PORT;
process.env.HOST = TEST_HOST;

let testsPassed = 0;
let testsFailed = 0;

console.log('╔════════════════════════════════════════════════════════╗');
console.log('║                                                        ║');
console.log('║              🧪 Running Test Suite 🧪                 ║');
console.log('║                                                        ║');
console.log('╚════════════════════════════════════════════════════════╝');
console.log('');

// Helper function to make HTTP requests
function makeRequest(path) {
  return new Promise((resolve, reject) => {
    const options = {
      hostname: TEST_HOST,
      port: TEST_PORT,
      path: path,
      method: 'GET'
    };

    const req = http.request(options, (res) => {
      let data = '';
      res.on('data', (chunk) => {
        data += chunk;
      });
      res.on('end', () => {
        resolve({ statusCode: res.statusCode, data, headers: res.headers });
      });
    });

    req.on('error', reject);
    req.end();
  });
}

// Test runner
async function runTests() {
  const server = require('./index.js');

  // Wait for server to start
  await new Promise(resolve => setTimeout(resolve, 1000));

  try {
    // Test 1: Root endpoint returns 200
    console.log('Test 1: Root endpoint (/) returns 200...');
    const rootResponse = await makeRequest('/');
    if (rootResponse.statusCode === 200) {
      console.log('✅ PASS: Root endpoint returns 200');
      testsPassed++;
    } else {
      console.log(`❌ FAIL: Expected 200, got ${rootResponse.statusCode}`);
      testsFailed++;
    }

    // Test 2: API endpoint returns JSON
    console.log('\nTest 2: API endpoint (/api/hello) returns JSON...');
    const apiResponse = await makeRequest('/api/hello');
    if (apiResponse.statusCode === 200 && apiResponse.headers['content-type'].includes('application/json')) {
      const json = JSON.parse(apiResponse.data);
      if (json.message === 'Hello World!' && json.status === 'success') {
        console.log('✅ PASS: API endpoint returns correct JSON');
        testsPassed++;
      } else {
        console.log('❌ FAIL: API response structure incorrect');
        testsFailed++;
      }
    } else {
      console.log('❌ FAIL: API endpoint did not return JSON');
      testsFailed++;
    }

    // Test 3: Health endpoint
    console.log('\nTest 3: Health endpoint (/health) returns healthy status...');
    const healthResponse = await makeRequest('/health');
    if (healthResponse.statusCode === 200) {
      const json = JSON.parse(healthResponse.data);
      if (json.status === 'healthy') {
        console.log('✅ PASS: Health endpoint returns healthy status');
        testsPassed++;
      } else {
        console.log('❌ FAIL: Health status incorrect');
        testsFailed++;
      }
    } else {
      console.log('❌ FAIL: Health endpoint did not return 200');
      testsFailed++;
    }

    // Test 4: 404 for unknown routes
    console.log('\nTest 4: Unknown routes return 404...');
    const notFoundResponse = await makeRequest('/unknown');
    if (notFoundResponse.statusCode === 404) {
      console.log('✅ PASS: Unknown routes return 404');
      testsPassed++;
    } else {
      console.log(`❌ FAIL: Expected 404, got ${notFoundResponse.statusCode}`);
      testsFailed++;
    }

  } catch (error) {
    console.error('❌ Test error:', error.message);
    testsFailed++;
  } finally {
    // Close server
    server.close();
  }

  // Print summary
  console.log('\n╔════════════════════════════════════════════════════════╗');
  console.log('║                                                        ║');
  console.log('║                   Test Summary                         ║');
  console.log('║                                                        ║');
  console.log('╚════════════════════════════════════════════════════════╝');
  console.log('');
  console.log(`✅ Tests Passed: ${testsPassed}`);
  console.log(`❌ Tests Failed: ${testsFailed}`);
  console.log(`📊 Total Tests: ${testsPassed + testsFailed}`);
  console.log('');

  // Exit with appropriate code
  process.exit(testsFailed > 0 ? 1 : 0);
}

// Run tests
runTests().catch(error => {
  console.error('Fatal error:', error);
  process.exit(1);
});

// Made with Bob
