'use strict';

module.exports = function(grunt) {

  grunt.loadNpmTasks('grunt-mocha-test');
  grunt.loadNpmTasks('grunt-release');
  grunt.loadNpmTasks('grunt-coffeelint');

  grunt.initConfig({
    mochaTest: {
      test: {
        options: {
          reporter: 'spec',
          require: ['coffee-script', 'test/blanket']
        },
        src: ['test/**/*-test.coffee']
      },
      coverage: {
        options: {
          reporter: "mocha-lcov-reporter",
          quiet: true,
          captureFile: "coverage/lcov.info"
        },
        src: ["test/**/*-test.coffee"]
      }
    },
    release: {
      options: {
        tagName: 'v<%= version %>',
        commitMessage: 'Prepared to release <%= version %>.'
      }
    },
    watch: {
      files: ['Gruntfile.js', 'test/**/*.coffee'],
      tasks: ['test']
    },
    coffeelint: {
      app: ['src/*.coffee', 'test/*.coffee'],
      options: {
        configFile: 'coffeelint.json'
      }
    },
    coveralls: {
      all: {
        src: "coverage/lcov.info"
      }
    }
  });

  grunt.event.on('watch', function(action, filepath, target) {
    grunt.log.writeln(target + ': ' + filepath + ' has ' + action);
  });

  // load all grunt tasks
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  grunt.registerTask('test', ['mochaTest']);
  grunt.registerTask('test:watch', ['watch']);
  grunt.registerTask('default', ['test']);
};
