# Contributing to Vizio TV Controller

Thank you for your interest in contributing to the Vizio TV Controller project! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Reporting Issues

1. **Check existing issues** to avoid duplicates
2. **Use the issue template** when creating new issues
3. **Provide detailed information**:
   - Steps to reproduce
   - Expected vs actual behavior
   - Environment details (OS, browser, Docker version)
   - Error messages or logs

### Suggesting Features

1. **Check existing feature requests** first
2. **Describe the use case** clearly
3. **Explain the benefits** to users
4. **Consider implementation complexity**

### Code Contributions

#### Getting Started

1. **Fork the repository**
2. **Clone your fork**:
   ```bash
   git clone https://github.com/your-username/vizio-tv-controller-frontend.git
   cd vizio-tv-controller-frontend
   ```

3. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Make your changes** following the coding standards below

5. **Test your changes**:
   ```bash
   # Test with Docker
   docker build -t vizio-tv-controller-test .
   docker run -p 8080:80 vizio-tv-controller-test
   
   # Test locally
   python server.py 8080
   ```

6. **Commit your changes**:
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

7. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

8. **Create a Pull Request**

#### Coding Standards

##### HTML
- Use semantic HTML elements
- Include proper accessibility attributes
- Validate HTML structure
- Use consistent indentation (2 spaces)

##### CSS
- Use BEM methodology for class naming
- Organize CSS with comments
- Use CSS custom properties for theming
- Ensure responsive design
- Validate CSS syntax

##### JavaScript
- Use ES6+ features
- Follow consistent naming conventions
- Add JSDoc comments for functions
- Handle errors gracefully
- Use async/await for API calls

##### Docker
- Keep Dockerfile minimal and efficient
- Use multi-stage builds when appropriate
- Include health checks
- Document environment variables

#### Commit Message Format

Use conventional commit format:
```
type(scope): description

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Test changes
- `chore`: Build/tooling changes

Examples:
```
feat(volume): add volume slider with preset buttons
fix(api): handle connection timeout errors
docs(readme): update deployment instructions
```

#### Pull Request Guidelines

1. **Title**: Clear, descriptive title
2. **Description**: Explain what and why, not how
3. **Testing**: Describe how you tested the changes
4. **Screenshots**: Include screenshots for UI changes
5. **Checklist**: Complete the PR checklist

### PR Checklist

- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Code is commented where necessary
- [ ] Documentation updated (if applicable)
- [ ] Tests added/updated (if applicable)
- [ ] All tests pass
- [ ] Docker build succeeds
- [ ] No console errors
- [ ] Cross-browser compatibility verified

## 🛠 Development Setup

### Prerequisites
- Docker and Docker Compose
- Node.js (for development tools)
- Git

### Local Development

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/vizio-tv-controller-frontend.git
   cd vizio-tv-controller-frontend
   ```

2. **Start development server**:
   ```bash
   # Using Python
   python server.py 8080
   
   # Using Node.js
   npm install
   npx serve .
   
   # Using Docker
   docker-compose up --build
   ```

3. **Access the app**: `http://localhost:8080`

### Testing

#### Manual Testing
- Test on different browsers (Chrome, Firefox, Safari, Edge)
- Test on mobile devices
- Test PWA installation
- Test offline functionality
- Test with different screen sizes

#### Automated Testing
```bash
# Run Docker tests
docker build -t test-image .
docker run --rm test-image

# Run linting
npm run lint  # if available
```

## 📋 Issue Templates

### Bug Report Template
```markdown
## Bug Description
Brief description of the bug

## Steps to Reproduce
1. Step 1
2. Step 2
3. Step 3

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Environment
- OS: [e.g., macOS, Windows, Linux]
- Browser: [e.g., Chrome 120, Firefox 119]
- Docker Version: [e.g., 24.0.5]
- Backend URL: [e.g., http://localhost:8000]

## Additional Information
- Screenshots (if applicable)
- Console errors (if any)
- Network tab information (if applicable)
```

### Feature Request Template
```markdown
## Feature Description
Brief description of the feature

## Use Case
Why is this feature needed?

## Proposed Solution
How should this feature work?

## Alternatives Considered
Other approaches you've considered

## Additional Information
- Mockups/screenshots
- Related issues
- Implementation notes
```

## 🏷 Labels

We use the following labels to categorize issues and PRs:

- `bug`: Something isn't working
- `enhancement`: New feature or request
- `documentation`: Improvements or additions to documentation
- `good first issue`: Good for newcomers
- `help wanted`: Extra attention is needed
- `question`: Further information is requested
- `wontfix`: This will not be worked on

## 📞 Getting Help

- **GitHub Issues**: For bugs and feature requests
- **GitHub Discussions**: For questions and general discussion
- **Documentation**: Check the README and DEPLOYMENT.md

## 🎉 Recognition

Contributors will be recognized in:
- The project README
- Release notes
- GitHub contributors page

Thank you for contributing to Vizio TV Controller! 🎬📺 