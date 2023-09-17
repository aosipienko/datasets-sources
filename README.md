## Style guides

### Git Commit Messages

* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 72 characters or fewer
* Reference issues and pull requests liberally after the first line

### Golang Styleguide

All Golang code should adhere to [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments). Package imports should be ordered with a blank line between each block:

* stdlib
* 3rd party
* internal

### Documentation Styleguide

Documentation should be provided in the Godoc format in the source files for all public interfaces. Other documentation should be written as Markdown files in the `docs` folder.
