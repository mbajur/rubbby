class CreateHottnessFunction < ActiveRecord::Migration
  def up
    execute <<-SPROC
      CREATE OR REPLACE FUNCTION hottness(in_t projects) RETURNS integer AS $$
        DECLARE
          week_half_life float;
          push_delta integer;
          created_delta integer;
          push_weight integer;
          watchers_weight float;
          hottness float;
        BEGIN
          week_half_life = 1.146 * (10 ^ -9);

          push_delta    = CAST(extract(epoch from now()) - extract(epoch from in_t.github_pushed_at) as integer);
          created_delta = CAST(extract(epoch from now()) - extract(epoch from in_t.github_created_at) as integer);

          push_weight     = 1;
          watchers_weight = 1.314 * (10 ^ 7);

          hottness = push_weight * exp(-1 * week_half_life * push_delta);
          hottness = hottness + watchers_weight * in_t.watchers_count / created_delta;

          RETURN CAST(hottness as integer);
        END;
      $$ LANGUAGE plpgsql;
    SPROC
  end

  def down
    execute "DROP FUNCTION IF EXISTS hottness(in_t projects)"
  end
end
