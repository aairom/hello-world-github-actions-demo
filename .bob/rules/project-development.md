# Project Development Rule

When working with projects:

1. **Project Contexct Guide**: Always check the links provided here to access the source code and documentation repositories for implementation:
   - Always refer to the project context to understand and verify the guidelines, rules and requirements for the project.
2. **Sources and Links**:
   - Understanding GitHub Actions: https://docs.github.com/en/actions/get-started/understand-github-actions
   - How to Automate Publishing with GitHub Actions: https://modelcontextprotocol.io/registry/github-actions
   - Model Context Protocol: https://modelcontextprotocol.io/
   - Model Context Protocol GitHub: https://github.com/modelcontextprotocol
   - Creating an example workflow: https://docs.github.com/en/actions/tutorials/create-an-example-workflow
   - Use GITHUB_TOKEN for authentication in workflows: https://docs.github.com/en/actions/tutorials/authenticate-with-github_token
   - Creating a JavaScript action: https://docs.github.com/en/actions/tutorials/create-actions/create-a-javascript-action
3. **Project Structure**: Follow these conventions:
   - The documents of the project should be created in "Docs" folder except readme.md
   - Always provide a Mermaid flow architecture for the project in the "Architecture.md" file
   - All the BASH scripts if needed, should be written in "scripts" folder
   - All the input documents are to be found in "input" folder
   - All the output documents which are asked to be provided should be writen in timestamped format in "output" folder
   - The result documents should be written in "output" folder, if the "output" folder does not exist, it should be created
   - Always provide README.md with architecture + workflow diagrams as described
   - Always provide a ".gitignore" file which filters/ignores any ".env" files or any folders whichs' names start with "_" (underscore) to be pushed to GitHub (e.g.: _sources/, _images/, _docs/... )
4. **Key Patterns**:
   - Always test the functionnality of the code you provide. 
   - When you make updates/enhancements and/or correct the bugs, update the existing documents and scripts, don't create new ones
5. **Misc**:
   - On a MacOS platform, don't use the port 5000, it is reserved for the "AirDrop" application