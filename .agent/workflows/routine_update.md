---
description: Routine update of documentation and git repositories
---

This workflow updates the commercial presentation and READMEs, then commits and pushes changes for all projects.

1. Review and update `commercial_presentation.md` with any new high-level features.
2. Review and update `README.md` in each project (`admin-app`, `b2b-app`, `b2c-app`, `waiter-app`, `api-server`) with new technical details.

3. Update `CHANGELOG.md` with a brief summary of changes.

4. Commit and push `garcom` (Root)
// turbo
5. cd c:\Users\dwolf\Sites\garcom && git add . && git commit -m "chore: routine documentation and code update"

6. Commit and push `admin-app`
// turbo
7. cd c:\Users\dwolf\Sites\garcom\admin-app && git add . && git commit -m "chore: routine documentation and code update" && git push

8. Commit and push `b2b-app`
// turbo
9. cd c:\Users\dwolf\Sites\garcom\b2b-app && git add . && git commit -m "chore: routine documentation and code update" && git push

10. Commit and push `b2c-app`
// turbo
11. cd c:\Users\dwolf\Sites\garcom\b2c-app && git add . && git commit -m "chore: routine documentation and code update" && git push

12. Commit and push `waiter-app`
// turbo
13. cd c:\Users\dwolf\Sites\garcom\waiter-app && git add . && git commit -m "chore: routine documentation and code update" && git push

14. Commit and push `api-server`
// turbo
15. cd c:\Users\dwolf\Sites\garcom\api-server && git add . && git commit -m "chore: routine documentation and code update"
