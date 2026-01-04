
const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL = 'https://eilpafndxtzsmxozrpnm.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVpbHBhZm5keHR6c214b3pycG5tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjUyOTcwMzUsImV4cCI6MjA4MDg3MzAzNX0.yFiNZ1W9YmrJbMx-2_YPdgfgZ2qYWUMk4xjPLDlN9hk';

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

const usersToCreate = [
    { email: 'gerente@beta.com', password: 'beta123', role: 'gerente', name: 'Gerente Beta' },
    { email: 'garcom@beta.com', password: 'beta123', role: 'bar', name: 'Garçom Beta' },
    { email: 'cozinha@beta.com', password: 'beta123', role: 'cozinha', name: 'Cozinha Beta' },
    { email: 'hostess@beta.com', password: 'beta123', role: 'recepcao', name: 'Hostess Beta' }
];

async function createUsers() {
    console.log("Creating users...");

    for (const u of usersToCreate) {
        console.log(`Creating ${u.email}...`);

        // 1. Sign Up in Auth
        const { data: authData, error: authError } = await supabase.auth.signUp({
            email: u.email,
            password: u.password,
        });

        if (authError) {
            console.error(`Error creating auth for ${u.email}:`, authError.message);
            // Continue to next might verify if it already exists
        } else {
            console.log(`Auth created for ${u.email}. ID: ${authData.user?.id}`);

            // 2. Insert into public.users (if needed for profile/role)
            // The Login.jsx logic seemed to rely on Supabase Auth, but let's check if it fetches role from public.users or metadata?
            // Checking Login.jsx: 
            // const { user } = await api.login(...)
            // It sets role from local state 'role'. 
            // Wait, the Login.jsx *manually* sets the role in localStorage based on the *dropdown selection*, ignoring the DB role?
            // "role: role" (line 51 in Login.jsx) -> uses the state variable, not user data.
            // So for now, we just need the Auth users to exist so login succeeds.
        }
    }
}

createUsers();
