# Contributing to Enterprise MariaDB Ansible Role

Thank you for your interest in contributing to this project! Here's how you can help.

## Code of Conduct

Please keep interactions respectful and professional.

## How Can I Contribute?

### Reporting Bugs

- Use the bug report template
- Include detailed steps to reproduce
- Specify your environment (OS, Ansible version, MariaDB version)

### Suggesting Features

- Use the feature request template
- Explain the use case for the feature
- Consider alternatives you've explored

### Pull Requests

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests to ensure they pass (`molecule test`)
5. Commit your changes (`git commit -m 'Add some amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## Development Process

### Testing

We use Molecule for testing. Before submitting a PR, make sure all tests pass:

```
molecule test
```

### Code Style

- Follow Ansible best practices
- Keep tasks idempotent
- Use YAML syntax consistently with 2-space indentation
- Document your code with comments where necessary

## Release Process

Releases are created by tagging commits:

1. Update version in metadata if needed
2. Create a tag (`git tag -a v1.0.0 -m "Release v1.0.0"`)
3. Push the tag (`git push origin v1.0.0`)
4. GitHub Actions will create a release automatically

## Questions?

If you have any questions, feel free to open an issue or contact the maintainers.

## CI dependency locks and offline security checks

CI installs binary distributions from SHA-256-verified dependency locks in
`requirements/`. Its Ansible 9 and 10 compatibility jobs use the published
9.0.1 and 10.0.1 releases; the formerly configured 9.0.0 and 10.0.0 do not
exist on PyPI. These jobs do not establish support for newer Ansible versions.
The lint hooks use Python 3.12 and their independently declared tool versions.

Regenerate locks with the tested `uv` 0.10.6 tool, selecting Python through
`mise` and retaining the Ubuntu 22.04-compatible Linux target:

```sh
mise exec python@3.12 -- uv pip compile requirements/ci-lint.in --python-version 3.12 --python-platform x86_64-manylinux_2_35 --only-binary :all: --generate-hashes --output-file requirements/ci-lint.txt
mise exec python@3.10 -- uv pip compile requirements/ci-ansible-9.0.1.in --python-version 3.10 --python-platform x86_64-manylinux_2_35 --only-binary :all: --generate-hashes --output-file requirements/ci-ansible-9.0.1.txt
mise exec python@3.10 -- uv pip compile requirements/ci-ansible-10.0.1.in --python-version 3.10 --python-platform x86_64-manylinux_2_35 --only-binary :all: --generate-hashes --output-file requirements/ci-ansible-10.0.1.txt
mise exec python@3.12 -- python -m unittest discover -s tests/unit -v
```

The offline tests substitute database and GitHub clients. They check failure
handling, exact-commit merge requests, and credential-file permissions without
contacting a server or changing an inventory. Run the named Molecule scenarios
in a deliberately selected disposable environment for deployment acceptance.

Backup and monitoring scripts contain rendered credentials and are root-only;
their template tasks redact output. Server configuration is readable by the
`mysql` group, and managed database directories exclude access by other users.
The development container runs as `mysql`. Bind mounts and existing data volumes
must already allow that user to access their contents; do not repair a live data
volume's permissions as part of routine development tests.

Dependabot merging runs after the named CI workflow completes, on its periodic
schedule, or on manual dispatch. It executes only trusted default-branch
metadata processing: it does not check out PR code or consume CI artifacts.
The GitHub API filters PR authors and supplies the exact commit passed to merge.
Both compatibility locks use the project-declared Docker SDK 7.2.0 so the
current Requests transport can connect to the runner's Docker daemon. The backup
directory is managed only by backup tasks, preventing ownership oscillation.
