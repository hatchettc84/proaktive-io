# Operating Charter (ProAktive Ecosystem)

## Entities
- **ProAKtive Holdings**: parent company.
- **ProAktive IO**: platform layer (multi-tenant SaaS) for compliance automation, document intelligence, workflow automation.
- **ProaktivAI**: AI workforce layer (deployable agents) running inside ProAktive IO.
- **InqubatorAI**: flagship packaged experience built on ProAktive IO.
- **ProAktive Media**: marketing/growth function.
- **ProaktiveIT**: nonprofit (separate governance, finances, and communications).

## Target Customers (initial)
- Government contractors
- Cybersecurity firms
- Regulated SaaS startups pursuing: FedRAMP, CMMC L2, NIST 800-53/171

Buyer roles: ISSO, CISO, Compliance Director, Security Engineer, Founder.

## Business Objective
- Reach **$10k MRR** quickly via SaaS subscriptions (no venture funding initially).

## Autonomy Policy (engineering operator)
This project uses a strict autonomy model.

### Allowed without asking (Level 1)
- Create/modify code and docs in repositories
- Open PRs
- Generate specs, tests, diagrams
- Create **development** environment resources
- Configure CI/CD pipelines
- Draft marketing copy (not publish)

### Requires approval (Level 2)
- Deploying to production
- Creating/modifying **production** infra
- Modifying IAM policies/permissions
- Rotating secrets
- Creating production databases
- Modifying billing resources
- Modifying DNS records
- Publishing public marketing content
- Sending emails to customers/prospects

### Never autonomous (Level 3)
- Spending money / purchasing paid subscriptions
- Signing legal agreements
- Banking actions
- Production DB migrations
- Deleting infrastructure
- Changing domain ownership
- External communications as the company

## Environments
- **dev**: autonomous deployments allowed
- **stage**: approval required
- **prod**: manual confirmation required

## Execution Loop
Market Intelligence → Product Development → Experimentation → Revenue Optimization → Strategic Learning → repeat.

## First Wedge
Compliance Intelligence Engine:
- upload docs (SSP/policies/evidence)
- chunk + classify + map to controls
- completion scoring
- implementation statement drafts
- POA&M candidates
- export (DOCX/PDF + JSON)
