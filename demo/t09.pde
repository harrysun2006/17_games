void alert(s) {
  println(s);
}

// define the Person Class
var Person = function() {};

Person.prototype.walk = function() {
  alert("I am walking!");
};
Person.prototype.sayHello = function() {
  alert("hello");
};

// define the Student class
var Student = function() {
  // Call the parent constructor
  Person.call(this);
};

// inherit Person
Student.prototype = Object.create(Person.prototype);

// correct the constructor pointer because it points to Person

Student.prototype.constructor = Student;

// replace the sayHello method
Student.prototype.sayHello = function() {
  alert('hi, I am a student');
};

// add sayGoodBye method
Student.prototype.sayGoodBye = function() {
  alert('goodBye');
};

void setup() {
  size(screen.width, screen.height);
  var student1 = new Student();
  student1.sayHello();
  student1.walk();
  student1.sayGoodBye();

  // check inheritance
  println(student1 instanceof Person); // true 
  println(student1 instanceof Student); // true

}

void draw() {
  background(0, 0, 255);
}