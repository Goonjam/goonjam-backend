var gulp = require('gulp');
var coffee = require('gulp-coffee');
var sourcemaps = require('gulp-sourcemaps');
var notify = require('gulp-notify');

gulp.task('default', ['coffee']);

gulp.task('coffee', function() {
  gulp.src('./src/**/*.coffee')
    .pipe(sourcemaps.init())
    .pipe(coffee({})).on('error', console.log)
    .pipe(notify())
    .pipe(sourcemaps.write('./maps'))
    .pipe(gulp.dest('build'));
});

gulp.task('watch', function() {
  gulp.watch([
    // 'src/*.coffee',
    'src/**/*.coffee'
    ], ['coffee']);
});
