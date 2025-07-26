# Ansible Development Guide

Complete guide for Ansible playbook and role development in your Neovim environment with specialized YAML support and Ansible-specific features.

## Essential Ansible Shortcuts

### File Type Detection
| File Pattern | Auto-Detection | Features Enabled |
|--------------|----------------|------------------|
| `*.yml` in ansible dirs | `yaml.ansible` | Ansible LSP, syntax, linting |
| `playbook.yml` | `yaml.ansible` | Full Ansible support |
| `roles/*/tasks/*.yml` | `yaml.ansible` | Task-specific completion |
| `group_vars/*.yml` | `yaml.ansible` | Variable validation |

### LSP Features
| Shortcut | Description | Ansible Benefit |
|----------|-------------|-----------------|
| `K` | Hover documentation | Show module documentation |
| `<leader>gd` | Go to definition | Jump to variable/role definitions |
| `<leader>gr` | Find references | Find variable usage |
| `<leader>ca` | Code actions | Ansible-lint fixes |
| `<leader>gf` | Format YAML | Proper Ansible formatting |

### Ansible Documentation
| Shortcut | Command | Description |
|----------|---------|-------------|
| `<leader>ad` | Ansible doc search | Search module documentation with Telescope |

## User Interaction Possibilities

### 1. **Module Documentation Access**
```yaml
- name: Install package
  apt:  # ← Cursor here → K → See apt module docs
    name: nginx
    state: present
```
**Features**:
- **Inline documentation**: Module parameters and examples
- **Real-time help**: No need to leave editor
- **Parameter validation**: See required vs optional parameters
- **Examples**: Copy-paste ready examples

### 2. **Variable Intelligence**
```yaml
# group_vars/all.yml
app_name: myapp
app_port: 8080

# playbook.yml
- name: Start application
  service:
    name: "{{ app_name }}"  # ← Auto-completion for variables
    state: started
```
**Capabilities**:
- **Variable completion**: Auto-suggest defined variables
- **Cross-file references**: Find variable definitions
- **Unused detection**: Highlight unused variables
- **Type validation**: Ensure proper variable usage

### 3. **Ansible Lint Integration**
```yaml
- name: bad task
  command: echo hello  # ← Highlighted by ansible-lint
  # Quick fix suggestions appear
```
**Benefits**:
- **Real-time linting**: See issues as you type
- **Best practices**: Enforce Ansible conventions
- **Security checks**: Detect potential security issues
- **Performance hints**: Suggest optimizations

### 4. **YAML Structure Validation**
```yaml
- hosts: all
  tasks:
    - name: Task name
      module_name:
        parameter: value  # ← Proper indentation enforced
```

## Developer Usability Features

### 1. **Intelligent Code Completion**
```yaml
- name: Configure nginx
  template:
    src: |  # ← Start typing → get parameter suggestions
    # Suggests: src, dest, backup, owner, group, mode, etc.
```

### 2. **Role Development Support**
```
roles/
├── common/
│   ├── tasks/main.yml     # ← Auto-detected as Ansible
│   ├── handlers/main.yml  # ← Proper syntax highlighting
│   └── vars/main.yml      # ← Variable completion
```

### 3. **Playbook Structure Navigation**
```yaml
# playbook.yml
- import_playbook: database.yml  # ← <leader>gd jumps to file
- include_role: 
    name: nginx                  # ← <leader>gd jumps to role
```

### 4. **Jinja2 Template Support**
```yaml
- name: Generate config
  template:
    src: app.conf.j2
    dest: /etc/app/app.conf
    # Template files get proper highlighting
```

## Advanced Ansible Workflows

### 1. **Multi-Environment Development**
```
inventories/
├── production/
│   ├── hosts.yml          # ← Environment-specific completion
│   └── group_vars/
├── staging/
│   ├── hosts.yml
│   └── group_vars/
```

**Workflow**:
1. `<leader>ff` → Find inventory files
2. `<C-n>` → Browse environment structure
3. `<leader>ad` → Search for modules
4. `K` → Get module documentation

### 2. **Role Testing Pattern**
```yaml
# molecule/default/molecule.yml
dependency:
  name: galaxy
driver:
  name: docker
platforms:
  - name: instance
    image: ubuntu:20.04
```

**Testing Workflow**:
1. Develop role in `roles/rolename/`
2. Write tests in `molecule/default/`
3. Use `:term` to run `molecule test`
4. Debug with ansible-lint integration

### 3. **Variable Management**
```yaml
# group_vars/all.yml
common_packages:
  - vim
  - git
  - curl

# host_vars/web01.yml  
ansible_host: 192.168.1.10
```

**Navigation Pattern**:
- `<leader>gr` on variable → Find all usages
- `<leader>gd` on variable → Jump to definition
- Auto-completion shows available variables

### 4. **Vault Integration**
```yaml
# Encrypted variables
database_password: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          66386439653765613...
```

**Security Features**:
- Vault file detection
- No password exposure in completion
- Proper syntax highlighting for encrypted content

## Module Development Support

### 1. **Custom Module Detection**
```python
# library/custom_module.py
from ansible.module_utils.basic import AnsibleModule

def main():
    module = AnsibleModule(
        argument_spec=dict(
            name=dict(type='str', required=True),
            state=dict(type='str', default='present')
        )
    )
```

### 2. **Filter Plugin Development**
```python
# filter_plugins/custom_filters.py
def custom_filter(value):
    return value.upper()

class FilterModule:
    def filters(self):
        return {'custom_filter': custom_filter}
```

## YAML-Specific Features

### 1. **Indentation Management**
- **Smart indentation**: Proper YAML structure maintained
- **Visual guides**: See indentation levels clearly
- **Auto-correction**: Fix common indentation errors

### 2. **Multi-document Support**
```yaml
---
- name: First play
  hosts: web

---
- name: Second play
  hosts: db
```

### 3. **Anchor & Reference Support**
```yaml
defaults: &defaults
  become: yes
  gather_facts: no

- name: Task 1
  <<: *defaults
  hosts: all
```

## Performance Optimizations

### 1. **Large Playbook Handling**
- **Lazy loading**: Only process visible sections
- **Syntax caching**: Fast re-highlighting
- **Memory efficient**: Handle large inventory files

### 2. **Real-time Validation**
- **Background processing**: Non-blocking lint checks
- **Incremental updates**: Only re-validate changed sections
- **Smart caching**: Remember validation results

### 3. **Network Efficiency**
- **Local documentation**: Cached module docs
- **Offline support**: Work without internet
- **Fast lookups**: Indexed documentation search

## Ansible Collections Support

### 1. **Collection Navigation**
```yaml
- name: Use collection module
  community.general.pacman:  # ← Full FQCN support
    name: vim
    state: present
```

### 2. **Collection Documentation**
- Full support for community collections
- Auto-completion for collection modules
- Documentation lookup for third-party modules

## Error Detection & Debugging

### 1. **Common Issues**
| Error Type | Detection | Quick Fix |
|------------|-----------|-----------|
| Syntax errors | Real-time highlighting | Auto-correction suggestions |
| Missing modules | Import validation | Suggest installation |
| Variable undefined | Reference checking | Show available variables |
| Deprecated usage | Version-aware linting | Suggest modern alternatives |

### 2. **Debugging Workflow**
```yaml
- name: Debug task
  debug:
    var: ansible_facts  # ← K shows available facts
```

### 3. **Dry-run Integration**
- Easy access to `--check` mode testing
- Syntax validation before execution
- Variable substitution preview

## Best Practices Integration

### 1. **Naming Conventions**
```yaml
- name: "Install {{ item.name }} package"  # ← Descriptive names enforced
  package:
    name: "{{ item.name }}"
    state: present
```

### 2. **Task Organization**
```yaml
- name: Web server tasks
  block:
    - name: Install nginx
      package: ...
    - name: Configure nginx
      template: ...
  tags:
    - webserver
```

### 3. **Error Handling**
```yaml
- name: Risky operation
  command: /usr/local/bin/script.sh
  register: result
  failed_when: result.rc not in [0, 2]
  ignore_errors: false
```

## Integration with External Tools

### 1. **Ansible Galaxy**
- Role and collection installation support
- Dependency management
- Version pinning assistance

### 2. **Testing Frameworks**
- Molecule integration
- Testinfra support
- Kitchen integration

### 3. **CI/CD Integration**
- Pipeline configuration assistance
- Ansible Vault handling
- Deployment automation

This Ansible development environment provides comprehensive support for infrastructure as code development, making complex automation tasks manageable and maintainable.