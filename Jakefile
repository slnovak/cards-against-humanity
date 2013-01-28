var spawn = require('child_process').spawn,
    mocha = spawn('mocha', ['--compilers','coffee:coffee-script','--ui','tdd','--recursive','--reporter','spec']);

namespace('test', function () {
  desc('Run all unit tests under unit/test.');
  task('all', function () {
    mocha.stdout.on('data', function (data) {
      console.log(data);
    });
  });
});
